require File.expand_path(File.dirname(__FILE__) + '/../helper')

class SubscriptionsAppTest < MiniTest::Unit::TestCase

  def app
    Sinatra::Application
  end

  def test_list_saved_subscriptions_in_json
    Subscription.create :name => "Gold" , :price => 12
    Subscription.create :name => "Silver" , :price => 6
    Subscription.create :name => "Bronze" , :price => 3

    get '/subscriptions'

    assert last_response.ok?
    assert_equal Subscription.all.to_json, last_response.body
  end

  def test_it_saves_the_subscription
    assert_difference("Subscription.count") do
      post '/subscriptions',  subscription: { name: "Gold" , price: 30 }
    end

    subscription = Subscription.all.first

    assert_equal "Gold",  subscription.name
    assert_equal 30, subscription.price
  end

  def test_deletes_a_subscription_giving_its_id
    Subscription.create :name => "ToBeDeleted", :price => 1
    Subscription.create :name => "Gold", :price => 10

    assert_difference("Subscription.count", -1) do
      delete '/subscriptions', { id: Subscription.first.id }
    end

    assert_equal "Gold" , Subscription.first.name
  end

end

