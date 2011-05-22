require File.expand_path(File.dirname(__FILE__) + '/../helper')

class CustomersServerest < MiniTest::Unit::TestCase

  def app
    Sinatra::Application
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
