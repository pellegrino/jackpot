module Jackpot

  module Payment
    extend self
    attr_accessor :gateway

    def pay(amount, customer, options={})
      # Authorize for the amount
      gateway.purchase(amount, customer.credit_card, options)  if customer.credit_card.valid?
    end

    def recurring(amount, customer)
      if customer.credit_card.valid?
        # Authorize for the amount
        response = gateway.purchase(amount, customer.credit_card)
        @last_response = @gateway.recurring(amount, customer.credit_card)

        @last_response.authorization if @last_response.success?
        if response.success?
          puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{customer.credit_card.display_number}"
        else
          raise StandardError, response.message
        end
      end

    end
  end
end
