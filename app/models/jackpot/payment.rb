module Jackpot
  class Payment < ActiveRecord::Base
    before_create :initialize_credit_card
    attr_accessor :credit_card 

    cattr_accessor :gateway

    def initialize_credit_card
      card = ActiveMerchant::Billing::CreditCard.new(self.credit_card)

      if card.valid? 
        response = Payment.gateway.authorize(self.amount, card)

        billing_response = Payment.gateway.capture(self.amount , response.authorization)
        self.token = billing_response.authorization
      else
        raise 'error'
      end 
      
    end 
  end
end
