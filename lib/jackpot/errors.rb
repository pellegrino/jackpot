module Jackpot

  Error                   = Class.new(StandardError)

  module Errors
    # Basic Jackpot error class
    # 
    # This error is raised when Jackpot::Payment.initialize_credit_card tries to
    # issue a payment to an invalid card     
    CardIsInvalid           = Class.new(Jackpot::Error)

    # This error indicates the Gateway was not initialized correctly  
    InvalidGateway          = Class.new(Jackpot::Error)
    CustomerHasNoCardSaved  = Class.new(Jackpot::Error)
    UnauthorizedPayment     = Class.new(Jackpot::Error)
  end 
    
end 
