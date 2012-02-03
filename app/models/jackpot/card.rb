module Jackpot

  # A simple adapter to Active Merchant's Card.  
  # 
  class Card 

    attr_accessor :number
    attr_accessor :year
    attr_accessor :month
    attr_accessor :verification_value

    def initialize(card_hash) 
      @am_card = ActiveMerchant::Billing::CreditCard.new(card_hash)

      @number              = card_hash['number']
      @year                = card_hash['year'  ]
      @month               = card_hash['month']
      @verification_value  = card_hash['verification_value']
    end 


    def masquerade_number
      "XXXX-XXXX-XXXX-#{@number.last(4)}" 
    end 

    def store
      Jackpot::Payment.gateway.store_card(self)
    end 

  end 
end 
