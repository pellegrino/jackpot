module Jackpot

  class Configuration

    attr_accessor :default_options
    attr_accessor :gateway

    def initialize
      @gateway = HashWithIndifferentAccess.new
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
   
  end 

end 
