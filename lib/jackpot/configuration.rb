module Jackpot

  # Simple object that stores mounting app's preferences
  class Configuration

    attr_accessor :gateway
    attr_accessor :mailer 

    def initialize
      @gateway = HashWithIndifferentAccess.new
      @mailer = HashWithIndifferentAccess.new
    end 

    def configure
      yield self

      ActiveMerchant::Billing::Base.mode = @gateway[:mode]
      Jackpot::Factory.new(gateway).build
    end 


    def gateway_type(gateway)
      @gateway[:type] = gateway 
    end 


    def gateway_login(login)
      @gateway[:login] = login 
    end 


    def gateway_password(password)
      @gateway[:password] = password 
    end 

    def gateway_mode(mode)
      @gateway[:mode] = mode 
    end 


    def default_from(from)
      @mailer[:from] = from
    end 
   
  end 

end 
