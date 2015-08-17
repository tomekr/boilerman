module Boilerman
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "creates a mount point for the engine in the routes file at /boilerman"
      source_root File.expand_path('../../../..', __FILE__)

      # This would copy a configuration file over if I ever needed it
      #def generate_initialization
        #copy_file 'config/initializers/boilerman.rb', 'config/initializers/boilerman.rb'
      #end

      def generate_routing
        route "mount Boilerman::Engine, at: 'boilerman'"
        log "# You can access the Boilerman URL at '/boilerman'"
      end
    end
  end
end
