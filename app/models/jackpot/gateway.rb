module Jackpot 

  # Small adapter for Active Merchant gateways Jackpot supports
  class Gateway

    def initialize(gateway)
      @gateway = gateway
    end 

    def method_missing(meth, *args)
      if @gateway.respond_to?(meth)
        @gateway.send(meth, *args)
      else
        super
      end
    end

    # TODO: Remove this ugly hack and move to a lighterweight PORO decorator approach
    def capture(money, authorization, options = {})
      @gateway.capture(money, authorization, options) 
    end 

    def respond_to?(meth)
      @gateway.respond_to?(meth)
    end

  end 
end 
