module Boilerman
  module Actions
    def self.get_action_hash
      # Biggie Smalls... Biggie Smalls... Biggie Smalls....
      routes =  Rails.application.routes.routes.routes.select do |route|
        # Select routes that point to a specific controller and action. Also
        # ignore routes that just redirect
        route.defaults.key?(:controller) &&
          !route.defaults.empty? &&
          route.app.class != ActionDispatch::Routing::Redirect
      end

      # We only care about the defaults which will give us an array of
      # controller/action hashes. We're also going to rearrange things a bit so
      # that the controller is the key and the value is an array of actions for that
      # controller. This will look like:
      #
      # {:controler_name1 => {"action1" => [filter1, filter2, ... , filterN]}}
      controller_action_hash = build_controller_action_list(routes)
      return build_filter_list(controller_action_hash)
    end

    private

    # Returns an array of strings as controller actions
    def self.actions_from_conditional(conditionals)
      if conditionals.size == 1
      elsif conditionals.size > 1
        conditionals.map do |conditional|
          conditional.scan(/'(.+?)'/).flatten
        end.flatten
      else
        return
      end
    end

    def self.build_controller_action_list(routes)
      routes.inject(Hash.new) do |route_hash, route|
        defaults = route.defaults

        begin
          # This is what Rails does to get from a String to an object we can
          # call methods on. Note that a NameError will get thrown if the class
          # doesn't exist in the app.
          #
          # See actionpack/lib/action_dispatch/routing/route_set.rb:67
          #
          # Progression goes something like this:
          # bank_accounts => BankAccounts => BankAccountsController
          controller = ActiveSupport::Dependencies.constantize("#{ defaults[:controller].camelize }Controller")

        rescue NameError
          # This error will get thrown if there is a route in config/routes.rb
          # that points to a controller that doesn't actually exist.

          route_hash[:_non_existant_route] ||= []
          # Keep a record of this in the form of "BankAccountsController#index"
          # so we can notify the user
          route_hash[:_non_existant_route] << "#{ defaults[:controller].camelize }Controller##{ defaults[:action] }"

          next # On to the next route since we don't have a controller to process
        end

        route_hash[controller] ||= []

        # we don't want duplicate actions in our array (this happens for PUT/PATCH routes
        route_hash[controller] << defaults[:action] unless route_hash[controller].include? defaults[:action]
        route_hash
      end
    end

    def self.build_filter_list(controller_action_hash)
      controller_action_filter_hash = {}

      # Initialize the return hash
      controller_action_hash.each do |controller, actions|
        controller_action_filter_hash[controller] = {}
        actions.each{|a| controller_action_filter_hash[controller][a] = [] }
      end

      # Initialize metadata keys.
      #
      # _proc_conditionals: keeps track of filters that call Procs to
      # decide whether or not a filter will be applied to an action.
      #
      # _method_conditionals: keeps track of filters that call methods within
      # the controller to decide whether or not a filter will be applied to an
      # action.
      controller_action_filter_hash[:_proc_conditionals] = {}
      controller_action_filter_hash[:_method_conditionals] = {}

      # All right, now we have a mapping of routable controllers and actions in
      # the application. Let's collect the before_actions that get run on each
      # controller action.
      controller_action_hash.each do |controller, actions|

        unless controller.respond_to?(:_process_action_callbacks)
          #FIXME: change this metadata key name
          controller_action_filter_hash[:_weird_controller] ||= []
          controller_action_filter_hash[:_weird_controller] << controller
          next
        end


        # We only care about before_actions
        controller._process_action_callbacks.select{|c| c.kind == :before}.each do |callback|

          # There is a slight disparity in the way conditional before_actions
          # are handled between Rails 3.2 and 4.x so we need to take this into
          # consideration here.

          # RAILS 3.2
          if callback.instance_variables.include?(:@options)
            options = callback.instance_variable_get(:@options)
            if_call, unless_call = options[:if], options[:unless]
          else # RAILS 4.x
            if_call, unless_call = callback.instance_variable_get(:@if), callback.instance_variable_get(:@unless)
          end

          # Keep track of before_actions that rely on Procs. Since we can't
          # really handle this in our code, we keep it in a metadata key and
          # present it to the user so they can check up on it themselves.
          if if_call.first.is_a?(Proc) || unless_call.first.is_a?(Proc)
            controller_action_filter_hash[:_proc_conditionals][controller] ||= []
            controller_action_filter_hash[:_proc_conditionals][controller] << callback.filter
            next
          end


          # Go through and process each condition
          if if_call.empty? && unless_call.empty?
            actions.each do |action|
              controller_action_filter_hash[controller][action] << callback.filter
            end
          elsif !if_call.empty? # before_(filter|action) only: [:foo, :bar, :baz]

            actions_to_filter = if_call.select{|call| call.is_a?(Symbol)}
            actions_to_filter << actions_from_conditional(if_call.select{|call| call.is_a?(Array)})

            actions_to_filter.flatten! unless actions_to_filter.empty?
            actions_to_filter.compact! unless actions_to_filter.empty?

            actions_to_filter.each do |action|
              next unless actions.include?(action)
              controller_action_filter_hash[controller][action] << callback.filter
            end

          elsif !unless_call.empty? # before_(filter|action) unless: [:qux]
            # Get all the symbols first
            unless_actions = unless_call.select{|call| call.is_a?(Symbol)}

            # Now process any Array based conditionas
            unless_actions << actions_from_conditional(unless_call.select{|call| call.is_a?(Array)})

            unless_actions.flatten! unless unless_actions.empty?
            unless_actions.compact! unless unless_actions.empty?

            # If the unless conditional isn't an action we won't include it because
            # similar to the proces this filter relies on the true/false output of a
            # method
            if (actions & unless_actions).empty?
              controller_action_filter_hash[:_method_conditionals][controller] ||= []
              controller_action_filter_hash[:_method_conditionals][controller] << {filter: callback.filter, conditional: unless_actions}
              next
            end

            actions.reject{|a| unless_actions.include?(a)}.each do |action|
              controller_action_filter_hash[controller][action] << callback.filter
            end
          end
        end
      end
      controller_action_filter_hash
    end
  end
end

