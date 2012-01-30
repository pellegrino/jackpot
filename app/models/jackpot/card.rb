module Jackpot

  class Card 
    
    def self.create(credit_card_params)
      ActiveMerchant::Billing::CreditCard.new(credit_card_params)
    end 

  end 
end 
