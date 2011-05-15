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
  def setup
    DataMapper.auto_migrate!
  end

  def assert_difference(method, &block)
    result = eval(method)
    yield(block)
    assert_equal result + 1 , eval(method) , "#{method} should have changed by one but it didn't"
  end
end

# adopted from: https://gist.github.com/839034
def context(*args, &block)
  return super unless (name = args.first) && block
  klass = Class.new(MiniTest::Unit::TestCase) do
    def self.test(name, &block)
      define_method("test_#{name.gsub(/\W/,'_')}", &block) if block
    end
    def self.xtest(*args) end
    def self.setup(&block) define_method(:setup, &block) end
    def self.teardown(&block) define_method(:teardown, &block) end
  end
  (class << klass; self end).send(:define_method, :name) { name.gsub(/\W/,'_') }

#  klass.send :include, DatabaseHelpers
  klass.class_eval &block
end
MiniTest::Unit.autorun
