$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hydramata/institution/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hydramata-institution"
  s.version     = Hydramata::Institution::VERSION
  s.authors     = [
    "Jeremy Friesen",
  ]
  s.email       = [
    "jeremy.n.friesen@gmail.com"
  ]
  s.homepage    = "http://github.com/hydramata/hydramaton"
  s.summary     = "Hydramata::Institution - Groups and Organizations."
  s.description = "Hydramata::Institution - Groups and Organizations."

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency "hydramata-core"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"

end
