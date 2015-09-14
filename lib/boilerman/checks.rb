module Boilerman
  module Checks

    # Return controllers that don't have inheritance_controller in it's
    # ancestor list. This method defaults to checking for ApplicationController.
    def self.inheritance_check(inheritance_controller="ApplicationController")
      inheritance_controller = inheritance_controller.constantize

      controllers = ActionController::Metal.descendants.reject do |controller|
        controller.parent == Boilerman || !controller.respond_to?(:_process_action_callbacks)
      end

      # On top of rejecting controllers which do not have the passed in
      # inheritance_controller, we also want to reject ActionController::Base
      # as this won't be a useful result (at least I don't think it will be)
      controllers.reject do |controller|
        controller.ancestors.include?(inheritance_controller) || controller == ActionController::Base
      end
    end
  end
end
