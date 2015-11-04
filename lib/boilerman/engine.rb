module Boilerman
  class Engine < ::Rails::Engine
    isolate_namespace Boilerman
    load_generators

    begin
      require 'bootstrap-sass'
      require 'gon'
      require 'jquery-rails'
      # XXX TODO This is a hack and isn't actually required by the boilerman
      # gem, however if boilerman is plugged into a Rails 4.2 application that
      # uses respond_with then I THINK boostrap-sass freaks out and throws an
      # error saying to require the responders gem.
      require 'responders'
    rescue LoadError
      puts "WARNING: You're probably side loading boilerman into a console.
          Note that you will only have console access to Boilerman and will be
          unable to access it via the /boilerman path"
    end
  end
end
