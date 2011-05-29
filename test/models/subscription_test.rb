require_relative '../helper'

class SubscriptionModelTest < MiniTest::Unit::TestCase
  include Jackpot::Models

  def test_has_many_customers
    @gold = Subscription.create :name => "Gold" , :price => 12

    assert_difference("@gold.customers.size") do
      @gold.customers << Customer.new(:first_name => "Foo",  :last_name => "Bar")
    end
  end


  def test_recurring_options
    @expected_recurring_options = {
      :periodicity => :monthly
    }

    subscription = Subscription.create(:name => "Gold", :price => 1000)
    assert_equal @expected_recurring_options, subscription.recurring_options
  end
end
