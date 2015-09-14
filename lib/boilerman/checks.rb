module Boilerman
  module Checks

    # Return controllers that don't have inheritance_controller in it's
    # ancestor list. This method defaults to checking for ApplicationController.
    def self.inheritance_check(inheritance_controller="ApplicationController")
      inheritance_controller = inheritance_controller.constantize

      # On top of rejecting controllers which do not have the passed in
      # inheritance_controller, we also want to reject ActionController::Base
      # as this won't be a useful result (at least I don't think it will be)
      Boilerman.controllers.reject do |controller|
        controller.ancestors.include?(inheritance_controller) || controller == ActionController::Base
      end
    end

    def self.csrf_check
      Boilerman::Actions.get_action_hash.select do |controller, actions|
        #TODO implement verify_authenticity_token filter checking logic
      end
    end
  end
end
