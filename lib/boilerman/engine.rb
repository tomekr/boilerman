module Boilerman
  class Engine < ::Rails::Engine
    isolate_namespace Boilerman
    load_generators

    require 'bootstrap-sass'
    require 'gon'
    require 'jquery-rails'
  end
end
