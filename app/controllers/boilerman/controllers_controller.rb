require_dependency "boilerman/application_controller"

module Boilerman
  class ControllersController < ApplicationController
    before_filter :eager_load

    def index
      @with_actions = []
      @without_actions = []
      @controller_filters = []

      @controllers = filtered_controllers
      @controllers_and_callbacks = @controllers.map do |controller|
        callbacks = controller._process_action_callbacks
        [controller, callbacks.select{|callback| callback.kind == :before}.map(&:filter)]
      end

      gon.controllers = @controllers.map{|x| x.to_s}
    end

    private
    def eager_load
      # FIXME This is required when developing boilerman and cache_classes is
      # set to false. Need to think of a proper workaround for this. Possibly
      # checking for a BOILERMAN_DEV enviornment variable and maybe changing
      # this line to:
      #
      # Rails.application.eager_load! if ENV["BOILERMAN_DEV"]
      #
      # But then you have to specifify that everytime you run the app server
      # for dev and if you forget it, debugging this is going not be fun.
      #
      # Alternatively, just eager_load on every request. It'll take a bit
      # longer but we can be sure the classes will be there and most of the
      # Boilerman usge is client side anyways.
      Rails.application.eager_load!
    end

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
