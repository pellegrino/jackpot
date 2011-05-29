require File.expand_path(File.dirname(__FILE__) + '/../helper')

class CustomersServerTest < MiniTest::Unit::TestCase
  include Jackpot::Models

  def app
    Sinatra::Application
  end

  def test_create_customer
    assert_difference("Jackpot::Models::Customer.count") do
      post '/customers', :customer => {
        :first_name => "John",
        :last_name => "Doe"
      }
    end
  end

  def test_get_all_customers
    Customer.create :first_name => "Foo" , :last_name => "Bar"
    Customer.create :first_name => "Bar" , :last_name => "Baz"

    get "/customers"

    assert last_response.ok?
    assert_equal "application/json", last_response.content_type
    assert_equal Customer.all.to_json, last_response.body
  end
end
