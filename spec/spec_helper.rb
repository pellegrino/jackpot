# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

if ENV["CI"]
  require 'coveralls'
  Coveralls.wear!
end

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'capybara/rspec'
require 'shoulda-matchers'
require 'database_cleaner'
require 'factory_girl_rails'
require 'vcr'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

ActionMailer::Base.delivery_method = :test

Jackpot.configure do |c|
  c.gateway_type      :braintree
  c.gateway_login    'demo'
  c.gateway_password 'password'  
  c.gateway_mode     :test
  c.default_from     'dont-reply@example.com'
end 
