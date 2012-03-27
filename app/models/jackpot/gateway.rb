module Jackpot 

  # Small adapter for Active Merchant gateways Jackpot supports
  class Gateway

    def initialize(gateway)
      @gateway = gateway
    end 


    def authorize(amount_in_cents, credit_card_token) 
      @gateway.authorize(amount_in_cents, credit_card_token)
    end 


    def store(card)
      @gateway.store(card)
    end 

    def capture(money, authorization, options = {})
      @gateway.capture(money, authorization, options) 
    end 

  end 
end 
