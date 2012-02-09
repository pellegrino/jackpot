module Jackpot
  class Payment < ActiveRecord::Base
    before_create :perform_payment

    attr_accessor :credit_card
    attr_accessor :credit_card_token

    belongs_to :subscription
    belongs_to :customer

    cattr_accessor :gateway

    def perform_payment
      credit_card_token = customer.credit_card_token
      if credit_card_token
        self.amount = self.subscription.price
        response = Jackpot::Payment.gateway.authorize       self.amount, credit_card_token
        billing_response = Jackpot::Payment.gateway.capture(self.amount, 
                                                             response.authorization) 

        self.payment_transaction_token = billing_response.params['transactionid']
      end 
    end 

    def customer_email
      customer.email
    end 
  end
end
