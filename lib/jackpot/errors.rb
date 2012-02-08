module Jackpot

  module Errors
    # 
    # This error is raised when Jackpot::Payment.initialize_credit_card tries to
    # issue a payment to an invalid card     
    CardIsInvalid   = Class.new(StandardError)

    # This error indicates the Gateway was not initialized correctly  
    InvalidGateway  = Class.new(StandardError)
    CustomerHasNoCardSaved  = Class.new(StandardError)
  end 
    
end 
