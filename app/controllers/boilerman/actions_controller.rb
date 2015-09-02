require_dependency "boilerman/application_controller"

module Boilerman
  class ActionsController < ApplicationController
    def index
      @action_filter_hash = Boilerman::Actions.get_action_hash
    end
  end
end
