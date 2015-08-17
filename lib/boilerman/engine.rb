require 'bootstrap-sass'
require 'gon'

module Boilerman
  class Engine < ::Rails::Engine
    isolate_namespace Boilerman
    load_generators
  end
end
