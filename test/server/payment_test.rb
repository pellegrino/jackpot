require File.expand_path(File.dirname(__FILE__) + '/../helper')

class PaymentTest < MiniTest::Unit::TestCase

  def test_pay
    customer = Customer.create :first_name => "Foo" , :last_name => "Bar"

    Jackpot::Payment.gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
                :login => 'TestMerchant',
                :password => 'password'
              )
    Jackpot::Payment.pay(100000, customer)
  end
end

