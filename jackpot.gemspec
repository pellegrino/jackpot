$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jackpot/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jackpot"

  s.version     = Jackpot::VERSION
  s.homepage = "http://github.com/pellegrino/jackpot"
  s.license = "MIT"
  s.summary = "Billing for rack apps"
  s.description = "Billing for rack apps"
  s.email = "vitorp@gmail.com"
  s.authors = ["Vitor Pellegrino"]

  s.files         = `git ls-files`.split("\n")

  s.add_dependency "rails",                           ">= 3.1"
  s.add_dependency "jquery-rails",                    ">= 2.0.0"
  s.add_dependency "formtastic-bootstrap"
  s.add_dependency "bootstrap-sass",                  "~> 2.0.0"
  s.add_dependency "coffee-rails"
  s.add_dependency "sass-rails",                      ">= 3.1"
  s.add_dependency "haml-rails"
  s.add_dependency "activemerchant",                  "~> 1.20.1"
  s.add_dependency "devise",                          "~> 2.0"

  s.add_development_dependency "devise",              "~> 2.0"
  s.add_development_dependency "capybara",            "~> 1.1"
  s.add_development_dependency "timecop",             "~> 0.3"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails",  ">= 1.2.0"
  s.add_development_dependency 'rspec-rails',         "~> 2.8"
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'shoulda-matchers',    "~> 1.0.0"
  s.add_development_dependency 'vcr',                 "~> 2.0.0.rc1"
  s.add_development_dependency 'fakeweb'
end
