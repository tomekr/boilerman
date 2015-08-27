require_dependency "boilerman/application_controller"

module Boilerman
  class ActionsController < ApplicationController
    def index
      @msg = "hello there"
      Boilerman::Actions.get_action_hash
    end
  end
end
