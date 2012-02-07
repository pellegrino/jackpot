require_relative 'errors'
module Jackpot

  class Factory
    

    def initialize(gateway_configuration)
      @gateway_configuration = gateway_configuration
    end 


    def build
     if @gateway_configuration['type'] == :braintree
       Jackpot::Gateway.new(ActiveMerchant::Billing::BraintreeGateway.new(
       :login =>    @gateway_configuration['login'], 
       :password => @gateway_configuration['password'], 
       :mode =>     @gateway_configuration['password'])) 
     else 
       raise Jackpot::Errors::InvalidGateway.new "There is no #{@gateway_configuration['type']}: available options are :braintree, :bogus"
     end 
     
    end 

  end 
end 
