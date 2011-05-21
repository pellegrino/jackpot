require File.expand_path("../lib/jackpot/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "jackpot"
  gem.homepage = "http://github.com/pellegrino/jackpot"
  gem.license = "MIT"
  gem.summary = "Billing for rack apps"
  gem.description = "Billing for rack apps"
  gem.email = "vitorp@gmail.com"
  gem.authors = ["Vitor Pellegrino"]


  gem.rubyforge_project = 'jackpot'

  gem.add_development_dependency "minitest", ">= 0"
  gem.add_development_dependency "bundler", "~> 1.0.0"
  gem.add_development_dependency "rcov", ">= 0"
  gem.add_development_dependency "reek", "~> 1.2.8"
  gem.add_development_dependency "roodi", "~> 2.1.0"
  gem.add_development_dependency 'sinatra', '~> 1.2.6'
  gem.add_development_dependency 'rack-test', '~> 0.5'
  gem.add_development_dependency 'ruby-debug19'
  gem.add_development_dependency 'mocha'

  gem.add_runtime_dependency 'i18n'               , '0.5.0'
  gem.add_runtime_dependency 'activemerchant'     , "1.12.1"
  gem.add_runtime_dependency 'rest-client'        , '~> 1.6'
  gem.add_runtime_dependency 'data_mapper'        , '~> 1.1'
  gem.add_runtime_dependency 'dm-core'            , '~> 1.1'
  gem.add_runtime_dependency 'dm-sqlite-adapter'  , '~> 1.1'
  gem.add_runtime_dependency 'dm-timestamps'      , '~> 1.1'
  gem.add_runtime_dependency 'dm-validations'     , '~> 1.1'
  gem.add_runtime_dependency 'dm-aggregates'      , '~> 1.1'
  gem.add_runtime_dependency 'dm-migrations'      , '~> 1.1'
  gem.add_runtime_dependency 'dm-serializer'      , '~> 1.1'

  gem.test_files = gem.files.select { |path| path =~ /^test\/.*_test\.rb/ }

end
