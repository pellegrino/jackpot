$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jackpot/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jackpot"

  s.version     = Jackpot::VERSION
  s.platform    = Gem::Platform::RUBY
  s.homepage = "http://github.com/pellegrino/jackpot"
  s.license = "MIT"
  s.summary = "Billing for rack apps"
  s.description = "Billing for rack apps"
  s.email = "vitorp@gmail.com"
  s.authors = ["Vitor Pellegrino"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]


  s.add_dependency "rails", "~> 3.1.3"
  s.add_dependency "jquery-rails"
  s.add_dependency "coffee-rails"
  s.add_dependency "sass-rails"
  s.add_dependency "haml-rails"
  s.add_dependency "activemerchant"
  s.add_dependency "formtastic-bootstrap"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "capybara", "~> 1.1"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'turn'
end
