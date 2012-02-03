module Jackpot 

  class Gateway

    def initialize(gateway)
      @gateway = gateway
    end 

    def store_card(card_hash)
      @gateway.store card_hash
    end 

  end 

end 
