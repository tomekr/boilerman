require_dependency "boilerman/application_controller"

module Boilerman
  class ControllersController < ApplicationController
    def index
      Rails.application.eager_load!
      @action_with_filters = []
      @action_without_filters = []
      @controller_filters = []

      @controllers = filtered_controllers
      @controllers_and_callbacks = @controllers.map do |controller|
        callbacks = controller._process_action_callbacks
        [controller, callbacks.select{|callback| callback.kind == :before}.map(&:filter)]
      end

      gon.controllers = @controllers.map{|x| x.to_s}
    end

    private

    def filtered_controllers
      # Process only controllers with callbacks and do not include
      # Boilerman's own controllers
      controllers = ActionController::Metal.descendants.reject do |controller|
        controller.parent == Boilerman || !controller.respond_to?(:_process_action_callbacks)
      end

      if params[:include_namespace]
        controllers.select!{|controller| params[:include_namespace].include?(controller.parent.to_s)}
      end

      controllers.sort_by{|c| c.to_s}
    end
  end
end
