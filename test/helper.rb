require 'rubygems'
require 'bundler'

ENV['RACK_ENV'] = 'test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'minitest/unit'

require 'jackpot'
require_relative '../jackpot_app'
require 'rack/test'

Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

DataMapper.setup(:default, "sqlite3::memory:")

class MiniTest::Unit::TestCase
  include Rack::Test::Methods
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
