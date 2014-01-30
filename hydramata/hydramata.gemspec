$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hydramata/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hydramata"
  s.version     = Hydramata::VERSION
  s.authors     = [
    "Jeremy Friesen",
  ]
  s.email       = [
    "jeremy.n.friesen@gmail.com"
  ]
  s.homepage    = "TODO"
  s.summary     = "The Foundational Hydramata Component"
  s.description = "The Foundational Hydramata Component"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]
  s.required_ruby_version = '>= 1.9.3'
  s.require_paths = ["lib"]
  s.licenses = ['APACHE2']

  s.add_dependency 'configatron', '3.0.0.rc1'
end
