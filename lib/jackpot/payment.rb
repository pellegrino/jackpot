module Jackpot

  module Payment
    extend self
    attr_accessor :gateway

    def pay(amount, customer, options={})
      @gateway.purchase(amount, customer.credit_card, options)  if customer.credit_card.valid?
    end

    def recurring(amount, customer, recurring_options)
      if customer.credit_card.valid?
        @gateway.recurring(amount, customer.credit_card, recurring_options)
      else
        raise 'Invalid Card!'
      end
    end
  end
end
