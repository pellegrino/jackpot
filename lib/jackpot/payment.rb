module Jackpot

  module Payment
    extend self
    attr_accessor :gateway

    def pay(amount, customer)
      credit_card = ActiveMerchant::Billing::CreditCard.new(
            :first_name         => customer.first_name,
            :last_name          => customer.last_name,
            :number             => '4242424242424242',
            :month              => '8',
            :year               => '2012',
            :verification_value => '123' )

      if credit_card.valid?
        # Authorize for the amount
        response = gateway.purchase(amount, credit_card)

        if response.success?
          puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
        else
          raise StandardError, response.message
        end
      end
    end
  end
end
