module Boilerman
  class Engine < ::Rails::Engine
    isolate_namespace Boilerman
    load_generators

    begin
      require 'bootstrap-sass'
      require 'gon'
      require 'jquery-rails'
    rescue LoadError
      puts "WARNING: You're probably side loading boilerman into a console.
          Note that you will only have console access to Boilerman and will be
          unable to access it via the /boilerman path"
    end
  end
end
