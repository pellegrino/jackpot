module Jackpot
  class Payment < ActiveRecord::Base
    before_create :initialize_credit_card
    attr_accessor :credit_card 

    cattr_accessor :gateway

    def initialize_credit_card
      card = Card.new(self.credit_card)
      if card.valid? 
        response = Jackpot::Payment.gateway.authorize(self.amount, card)

        billing_response = Jackpot::Payment.gateway.capture(self.amount, response.authorization)
        self.token = billing_response.params['transactionid']
        self.customer_name =  "#{card.first_name} #{card.last_name}"
      else
        raise Jackpot::Errors::CardIsInvalid 
      end 
    end 
  end
end
