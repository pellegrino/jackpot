require_relative '../helper'

class CustomerModelTest < MiniTest::Unit::TestCase

  def test_client_is_valid_without_subscription_associated
    assert_difference("Customer.count") do
      @customer = Customer.create :first_name => "John" , :last_name => "Doe"
    end

    assert @customer.valid?
  end

  def test_client_adheres_to_a_subscription
    subscription = Subscription.create :name => "gold", :price => 1000

    customer_with_valid_card.subscribe! subscription
    assert_equal subscription ,  customer_with_valid_card.subscription

    retrieved_customer = Customer.get(customer_with_valid_card.id)
    assert_equal subscription , retrieved_customer.subscription
  end

  def test_client_cancels_subscriptions
    customer_with_valid_card.subscribe! Subscription.create :name => "gold", :price => 1000

    customer_with_valid_card.unsubscribe!

    assert_nil customer_with_valid_card.subscription
  end
end
