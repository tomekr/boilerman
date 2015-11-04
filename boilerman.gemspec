$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "boilerman/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "boilerman"
  s.version     = Boilerman::VERSION
  s.authors     = ["Tomek Rabczak"]
  s.email       = ["tomek.rabczak@gmail.com"]
  s.homepage    = "https://github.com/tomekr/boilerman"
  s.summary     = "A Rails dynamic analysis tool"
  s.description = "A tool used to help with testing/auditing the security of a Rails application."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2"
  s.add_dependency "jquery-rails"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "sass-rails"
  s.add_dependency "gon"
  s.add_dependency "responders"

  # TODO: Are we going to need this at some point? Might be good to use a
  # database for easier/faster querying of application data
  #s.add_development_dependency "sqlite3"
end
