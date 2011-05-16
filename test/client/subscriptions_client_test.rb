require_relative '../helper'

class SubscriptionsClientTest < MiniTest::Unit::TestCase

  def setup
    # TODO: Move to a fixture
    @json = "[{\"id\":1,\"name\":\"Bronze\",\"price\":3,\"created_at\":\"2011-05-15T22:49:17-03:00\",\"updated_at\":\"2011-05-15T22:49:17-03:00\"},{\"id\":2,\"name\":\"Free\",\"price\":0,\"created_at\":\"2011-05-15T22:49:32-03:00\",\"updated_at\":\"2011-05-15T22:49:32-03:00\"},{\"id\":3,\"name\":\"Gold\",\"price\":10,\"created_at\":\"2011-05-15T22:49:45-03:00\",\"updated_at\":\"2011-05-15T22:49:45-03:00\"},{\"id\":4,\"name\":\"Silver\",\"price\":7,\"created_at\":\"2011-05-15T22:49:58-03:00\",\"updated_at\":\"2011-05-15T22:49:58-03:00\"}]"

    Jackpot::Client.stubs(:get).returns(@json)
  end

  def test_list_every_subscription_jackpot_has
    subscriptions = Jackpot::Subscription.list

    assert_equal 4 , subscriptions.size

    assert_equal "Bronze", subscriptions.first["name"]
    assert_equal 3 , subscriptions.first["price"]

    assert_equal "Silver", subscriptions.last["name"]
    assert_equal 7, subscriptions.last["price"]
  end

end
