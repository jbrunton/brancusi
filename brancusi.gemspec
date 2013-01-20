$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "brancusi/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "brancusi"
  s.version     = Brancusi::VERSION
  s.authors     = ["John Brunton"]
  s.email       = ["john_brunton@hotmail.co.uk"]
  s.homepage    = "https://github.com/jbrunton/brancusi"
  s.summary     = "An opinionated CoffeeScript framework for developing single page applications."
  s.description = "An opinionated CoffeeScript framework for developing single page applications."

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["Rakefile"]
  s.require_paths = ["lib"]

  s.add_dependency "rails"
  s.add_dependency "railties"
  s.add_dependency "coffee-script"

  s.add_development_dependency "sqlite3"

  s.add_development_dependency 'actionpack'
  s.add_development_dependency 'tzinfo'

  s.add_development_dependency 'thin'

  s.add_development_dependency 'jasminerice'
  s.add_development_dependency 'jasmine-stories'
  s.add_development_dependency 'guard-jasmine'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'underscore-rails'
end
