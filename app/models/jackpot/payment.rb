module Jackpot
  class Payment < ActiveRecord::Base
    before_create :perform_payment

    attr_accessor :credit_card
    attr_accessor :credit_card_token

    belongs_to :subscription
    belongs_to :customer

    def perform_payment
      credit_card_token = customer.credit_card_token
      if credit_card_token
        self.amount = self.subscription.price_in_cents
        response = Jackpot::Base.gateway.authorize(self.amount_in_cents, credit_card_token)

        if response.success?
          billing_response = Jackpot::Base.gateway.capture(self.amount_in_cents, 
                                                               response.authorization) 
          self.payment_transaction_token = billing_response.params['transactionid']
        else
          raise Jackpot::Errors::UnauthorizedPayment.new
        end
      else
        raise Jackpot::Errors::CustomerHasNoCardSaved.new
      end 
    end 

    def customer_email
      customer.email
    end 

    def amount
      amount_in_cents / 100 unless amount_in_cents.nil?
    end 

    def amount_in_cents
      read_attribute(:amount) 
    end 
  end
end
