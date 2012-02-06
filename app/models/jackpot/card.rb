module Jackpot

  # A simple adapter to Active Merchant's Card.  
  # 
  class Card 

    attr_accessor :number
    attr_accessor :year
    attr_accessor :month
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :verification_value

    attr_reader   :adapted_card 

    def initialize(card_hash) 
      @number              = card_hash['number']
      @year                = card_hash['year'  ]
      @month               = card_hash['month']
      @first_name          = card_hash['first_name']
      @last_name           = card_hash['last_name']
      @verification_value  = card_hash['verification_value']


      @adapted_card        = ActiveMerchant::Billing::CreditCard.new(card_hash)

      @adapted_card.valid?
    end 


    def masquerade_number
      "XXXX-XXXX-XXXX-#{@number.last(4)}" 
    end 

  end 
end 
