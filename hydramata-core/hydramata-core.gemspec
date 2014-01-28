$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hydramata/Core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hydramata-core"
  s.version     = Hydramata::Core::VERSION
  s.authors     = [
    "Jeremy Friesen",
  ]
  s.email       = [
    "jeremy.n.friesen@gmail.com"
  ]
  s.homepage    = "TODO"
  s.summary     = "A Hydramata Component for Coreing Works"
  s.description = "A Hydramata Component for Coreing Works"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]
  s.required_ruby_version = '>= 1.9.3'
  s.require_paths = ["lib"]
  s.licenses = ['APACHE2']

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency 'virtus'

  s.add_development_dependency "sqlite3"
end
