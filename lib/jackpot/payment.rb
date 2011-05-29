require_relative 'payment/initializer'

module Jackpot

  module Payment
    extend self

    def pay(amount, customer, options={})
      Base.gateway.purchase(amount, customer.credit_card, options)  if customer.credit_card.valid?
    end

    def recurring(amount, customer, recurring_options)
      if customer.credit_card.valid?
        Base.gateway.recurring(amount, customer.credit_card, recurring_options)
      else
        raise 'Invalid Card!'
      end
    end

    class Base
      mattr_accessor :gateway
    end
  end

end
