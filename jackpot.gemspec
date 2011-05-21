# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require File.expand_path("../lib/jackpot/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "jackpot"
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


  s.rubyforge_project = 'jackpot'


  s.add_development_dependency "minitest", ">= 0"
  s.add_development_dependency "bundler", "~> 1.0.0"
  s.add_development_dependency "rcov", ">= 0"
  s.add_development_dependency "reek", "~> 1.2.8"
  s.add_development_dependency "roodi", "~> 2.1.0"
  s.add_development_dependency 'sinatra', '~> 1.2.6'
  s.add_development_dependency 'rack-test', '~> 0.5'
  s.add_development_dependency 'ruby-debug19'
  s.add_development_dependency 'mocha'

  s.add_dependency 'i18n'               , '0.5.0'
  s.add_dependency 'activemerchant'     , "1.12.1"
  s.add_dependency 'rest-client'        , '~> 1.6'
  s.add_dependency 'data_mapper'        , '~> 1.1'
  s.add_dependency 'dm-core'            , '~> 1.1'
  s.add_dependency 'dm-sqlite-adapter'  , '~> 1.1'
  s.add_dependency 'dm-timestamps'      , '~> 1.1'
  s.add_dependency 'dm-validations'     , '~> 1.1'
  s.add_dependency 'dm-aggregates'      , '~> 1.1'
  s.add_dependency 'dm-migrations'      , '~> 1.1'
  s.add_dependency 'dm-serializer'      , '~> 1.1'
end
