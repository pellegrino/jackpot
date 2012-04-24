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

    def process_payment(credit_card_token, amount_in_cents)
      if credit_card_token
        response = Jackpot::Base.gateway.authorize(amount_in_cents, credit_card_token)

        if response.success?
          billing_response = Jackpot::Base.gateway.capture(amount_in_cents, response.authorization).authorization
        else
          raise Jackpot::Errors::UnauthorizedPayment.new
        end
      else
        raise Jackpot::Errors::CustomerHasNoCardSaved.new
      end 
    end

  end 
end 
