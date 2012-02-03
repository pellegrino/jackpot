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
        self.token = billing_response.params['transid']
        self.customer_name =  "#{card.first_name} #{card.last_name}"
      else
        raise Jackpot::Errors::CardIsInvalid 
      end 
    end 
  end
end

# TODO: Remove this hardcoded info and extract to an initializer or something 
# equivalent 
# see: https://github.com/pellegrino/jackpot/issues/5
ActiveMerchant::Billing::Base.mode = :test
Jackpot::Payment.gateway = Jackpot::Gateway.new(ActiveMerchant::Billing::BogusGateway.new)
