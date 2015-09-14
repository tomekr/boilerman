require_dependency "boilerman/application_controller"

module Boilerman
  class ChecksController < ApplicationController
    def index
      @checks = []
    end

    def inheritance_check
      @inheritance_controller = params[:inheritance_controller] || "ApplicationController"
      begin
        @controllers = Boilerman::Checks.inheritance_check @inheritance_controller
      rescue NameError
        # The user has passed in a class that does not exist in the application.
        @error = "#{ @inheritance_controller } is not a class that exists in the application"
      end
    end

    def csrf
    end
  end
end
