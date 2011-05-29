require 'rubygems'
require 'bundler'

ENV['RACK_ENV'] = 'test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'minitest/unit'

require_relative '../lib/jackpot/clients'
require_relative '../lib/jackpot/app'
require_relative '../lib/jackpot'

require 'rack/test'

Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

DataMapper.setup(:default, "sqlite3::memory:")

class MiniTest::Unit::TestCase
  include Rack::Test::Methods
  require 'mocha'

  # payment settings
  ActiveMerchant::Billing::Base.mode = :test
  Jackpot::Payment.gateway = ActiveMerchant::Billing::BogusGateway.new

  def setup
    DataMapper.auto_migrate!
  end

  def assert_difference(method,difference=1, &block)
    result = eval(method)
    yield(block)
    assert_equal result + difference , eval(method) , "#{method} should have changed by #{difference} but it didn't"
  end

  def customer_with_valid_card
    @customer_with_valid_card ||= Jackpot::Models::Customer.create(:first_name => "Foo" ,
                                                                   :last_name => "Bar",
                                                                   :credit_card => { :number => "1",
                                                                     :month => "12",
                                                                     :year => Date.today.year + 1,
                                                                     :verification_value => "123" })
  end
  def customer_with_invalid_card
    @customer_with_invalid_card ||= Jackpot::Models::Customer.create(:first_name => "Foo" ,
                                                                     :last_name => "Bar",
                                                                     :credit_card => { :number => "2",
                                                                       :month => "12",
                                                                       :year => Date.today.year + 1,
                                                                       :verification_value => "123" })
  end
end

MiniTest::Unit.autorun
