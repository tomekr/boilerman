require "boilerman/engine"

module Boilerman
    def self.eager_load_rails_paths
        Rails.configuration.eager_load_paths.each do |path|
          Dir[path + "/*.rb"].each do |file|
            require file
          end
        end
    end

    # This lets me tap into Rails initialization events. before_initialize is a
    # hook after configuration is completed but right before the applicaiton gets
    # initialized.
    #
    # See http://edgeguides.rubyonrails.org/configuring.html#initialization-events
    class InitializationHooks < Rails::Railtie
      config.before_initialize do |app|
        if Rails.env.development?
          # Force eager loading of namespaces so that Boilerman has immeddiate
          # access to all controllers and models in development enviornments.
          #
          # Note, this will not propogate code changes and will require server
          # restarts if you change code.
          app.config.eager_load = true
          app.config.cache_classes = true
        end
      end
    end
end
