require File.expand_path(File.dirname(__FILE__) + '/../helper')

class PaymentTest < MiniTest::Unit::TestCase
  include Jackpot::Models

  def setup
    @gold_subscription = Subscription.create(:name => "Gold", :price => 10000)
    @recurring_options =   @gold_subscription.recurring_options
  end

  def test_single_pay
    assert  Jackpot::Payment.pay(100000, customer_with_valid_card).success?
  end

  def test_recurring
    response =  Jackpot::Payment.recurring(100000, customer_with_valid_card, @recurring_options)
    assert      response.success?
  end
end

