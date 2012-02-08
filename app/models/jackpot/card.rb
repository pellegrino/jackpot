module Jackpot

  # A simple decorator to Active Merchant's Card.  
  # 
  class Card 
    def initialize(card_hash) 
      @component  = ActiveMerchant::Billing::CreditCard.new(HashWithIndifferentAccess.new(card_hash))
    end 

    def method_missing(meth, *args)
      if @component.respond_to?(meth)
        @component.send(meth, *args)
      else
        super
      end 
    end 

    def respond_to?(meth)
      unless @component.respond_to?(meth)
        super.respond_to? meth
      end
    end 

    def masquerade_number
      "XXXX-XXXX-XXXX-#{number.last(4)}" 
    end 

  end 
end 
