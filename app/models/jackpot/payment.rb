require 'active_support/secure_random'

module Jackpot
  class Payment < ActiveRecord::Base
    before_create :perform_payment
    after_create  :send_receipt

    attr_accessor :credit_card
    attr_accessor :credit_card_token

    belongs_to :subscription
    belongs_to :customer

    def self.public_fetch(payment_id, params)
      find_by_id_and_public_token! payment_id , params[:public_token]
    end 

    def perform_payment
      credit_card_token = customer.credit_card_token
      # Sets a public token so it can be accessed without being signed in
      self.public_token  ||= SecureRandom.hex(16)
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

    def send_receipt
      Jackpot::Notifier.send_receipt(self).deliver
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
