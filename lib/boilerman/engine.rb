require 'bootstrap-sass'
require 'gon'

module Boilerman
  class Engine < ::Rails::Engine
    isolate_namespace Boilerman
  end
end