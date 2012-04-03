module Jackpot 

  # Small adapter for Active Merchant gateways Jackpot supports
  class Gateway

    def initialize(adapted_gateway)
      @adapted_gateway = adapted_gateway
    end 


    def authorize(amount_in_cents, credit_card_token) 
      @adapted_gateway.authorize(amount_in_cents, credit_card_token)
    end 


    def store(card)
      @adapted_gateway.store(card)
    end 

    def capture(money, authorization, options = {})
      @adapted_gateway.capture(money, authorization, options) 
    end 

  end 
end 
