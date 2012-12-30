$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "brancusi/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "brancusi"
  s.version     = Brancusi::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Brancusi."
  s.description = "TODO: Description of Brancusi."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.9"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"

  s.add_development_dependency 'coffee-script'
  s.add_development_dependency 'actionpack'
  s.add_development_dependency 'railties'
  s.add_development_dependency 'tzinfo'

  s.add_development_dependency 'thin'

  s.add_development_dependency 'jasminerice'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'guard-jasmine'
end
