require_relative '../helper'

class SubscriptionModelTest < MiniTest::Unit::TestCase

  def test_recurring_options
    @expected_recurring_options = {
      :periodicity => :monthly
    }

    subscription = Subscription.create(:name => "Gold", :price => 1000)
    assert_equal @expected_recurring_options, subscription.recurring_options
  end
end
