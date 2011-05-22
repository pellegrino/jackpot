require File.expand_path(File.dirname(__FILE__) + '/../helper')

class PaymentTest < MiniTest::Unit::TestCase

  def setup
    @customer_with_valid_card = Customer.create(:first_name => "Foo" , :last_name => "Bar", :credit_card => { :number => "1", :month => "12", :year => Date.today.year + 1, :verification_value => "123" })
    @customer_with_invalid_card = Customer.create(:first_name => "Foo" , :last_name => "Bar", :credit_card => { :number => "2", :month => "12", :year => Date.today.year + 1, :verification_value => "123" })

  end
  def test_single_pay
    assert Jackpot::Payment.pay(100000, @customer_with_valid_card).success?

    refute Jackpot::Payment.pay(100000, @customer_with_invalid_card).success?
  end

  def test_recurring
    Jackpot::Payment.recurring(100000, @customer_with_valid_card)
  end
end

