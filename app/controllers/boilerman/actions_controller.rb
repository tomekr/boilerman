require_dependency "boilerman/application_controller"

module Boilerman
  class ActionsController < ApplicationController
    def index
      params = {filters: {controller_filters: [], # XXX Implemented
                          with_actions: [],
                          without_actions: [],
                          with_filters: [], # XXX Implemented
                          without_filters: [], # XXX Implemented
                          ignore_filters: [], # XXX Implemented
                          ignore_actions: []}} # XXX Implemented

      filters = params[:filters]

      @controller_filters     = filters[:controller_filters]

      @with_actions           = filters[:with_actions]
      @without_actions        = filters[:without_actions]

      @with_filters           = filters[:with_filters]
      @without_filters        = filters[:without_filters]

      @ignore_filters         = filters[:ignore_filters]
      @ignore_actions         = filters[:ignore_actions]

      @action_filter_hash = Boilerman::Actions.get_action_hash(filters)
    end
  end
end
