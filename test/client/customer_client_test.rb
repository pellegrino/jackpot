require_relative '../helper'

class CustomerClientTest < MiniTest::Unit::TestCase
  def setup
    @resource_url = "http://localhost:4567/customers"

    @json_john_doe = File.read("#{File.dirname(__FILE__)}/fixtures/customer_john_doe.json")

    @customer_hash = { :first_name => "John", :last_name => "Doe" }
  end


  def test_list_every_customer
    RestClient.stubs(:get).returns(@json_john_doe)

    customers  = Jackpot::Customer.list
    assert_equal 1, customers.size
  end

  def test_create_customer
    RestClient.expects(:post).with(@resource_url, { :customer => @customer_hash })

    Jackpot::Customer.create @customer_hash
  end
end
