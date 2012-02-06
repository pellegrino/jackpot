# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

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
# Using active merchant in test mode
#
# TODO: Remove this hardcoded info and extract to an initializer or something 
# equivalent 
# see: https://github.com/pellegrino/jackpot/issues/5
ActiveMerchant::Billing::Base.mode = :test
Jackpot::Payment.gateway = Jackpot::Gateway.new(ActiveMerchant::Billing::BogusGateway.new)

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
