$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jackpot/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jackpot"
  s.version     = Jackpot::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Jackpot."
  s.description = "TODO: Description of Jackpot."
  s.files = `git ls-files`.split("\n")

  s.add_dependency "rails", "~> 3.1.3"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
end
