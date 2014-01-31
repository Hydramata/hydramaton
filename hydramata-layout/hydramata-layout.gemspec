$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hydramata/layout/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hydramata-layout"
  s.version     = Hydramata::Layout::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Hydramata::Layout."
  s.description = "TODO: Description of Hydramata::Layout."

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency 'bootstrap-sass', '~>2.3'
  s.add_dependency 'hydramata-core'
  s.add_dependency 'bootstrap-datepicker-rails'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
