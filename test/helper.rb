require 'rubygems'
require 'bundler'

ENV['RACK_ENV'] = 'test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'minitest/unit'

require_relative '../jackpot_app'
require_relative '../jackpot_client'

require 'rack/test'

Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

DataMapper.setup(:default, "sqlite3::memory:")

class MiniTest::Unit::TestCase
  include Rack::Test::Methods

  # payment settings
  ActiveMerchant::Billing::Base.mode = :test
  Jackpot::Payment.gateway = ActiveMerchant::Billing::BogusGateway.new

  require 'mocha'

  def setup
    DataMapper.auto_migrate!
  end

  def assert_difference(method,difference=1, &block)
    result = eval(method)
    yield(block)
    assert_equal result + difference , eval(method) , "#{method} should have changed by #{difference} but it didn't"
  end
end

MiniTest::Unit.autorun
