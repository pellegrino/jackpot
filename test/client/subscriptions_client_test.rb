require_relative '../helper'

class SubscriptionsClientTest < MiniTest::Unit::TestCase

  def setup
    @resource_url = "http://localhost:4567/subscriptions"
    @subscription_hash = { :name => "Gold", :price => 10 }

    @json_all_subscriptions = File.read("#{File.dirname(__FILE__)}/fixtures/subscriptions.json")
    @json_gold_subscription = File.read("#{File.dirname(__FILE__)}/fixtures/gold_subscription.json")
  end

  def test_retrieves_a_subscription_given_its_url
    RestClient.expects(:get).with("#{@resource_url}/1", { :accept => :json , :content_type => :json }).returns(@json_gold_subscription)

    # Check test/client/fixtures for information
    subscription = Jackpot::Subscription.find 1
    refute_nil subscription
    assert_equal "Gold" , subscription["name"]
    assert_equal 10, subscription["price"]
  end

  def test_creates_a_new_subscription
    RestClient.expects(:post).with(@resource_url, { :subscription => @subscription_hash })

    Jackpot::Subscription.create @subscription_hash
  end

  def test_updates_the_subscription
    RestClient.expects(:put).with(@resource_url, { :id => 1 , :subscription => @subscription_hash})

    Jackpot::Subscription.update(1, @subscription_hash)
  end

  def test_deletes_a_subscription_given_its_id
    RestClient.expects(:delete).with(@resource_url, { :id => 1 })
    Jackpot::Subscription.destroy(1)
  end

  def test_list_every_subscription_jackpot_has
    RestClient.stubs(:get).returns(@json_all_subscriptions)

    subscriptions = Jackpot::Subscription.list

    assert_equal 4 , subscriptions.size

    assert_equal "Bronze", subscriptions.first["name"]
    assert_equal 3 , subscriptions.first["price"]

    assert_equal "Silver", subscriptions.last["name"]
    assert_equal 7, subscriptions.last["price"]
  end

end
