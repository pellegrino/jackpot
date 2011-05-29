require_relative 'gateways'

module Jackpot

  module Payment
    module Initializer
      class UnsupportedGatewayException < Exception ; end

      extend self

      def init(payment_configuration)
        ActiveMerchant::Billing::Base.mode = payment_configuration['mode']
        Jackpot::Payment::Base.gateway = create_gateway(payment_configuration)
      end

      private
      def create_gateway(payment_configuration)
        if payment_configuration["gateway"] == 'bogus'
          Jackpot::Payment::Gateways::Bogus.new
        elsif payment_configuration["gateway"] == 'authorize_net'
          Jackpot::Payment::Gateways::AuthorizeNet.new(:login => payment_configuration['login'],
                                                       :password => payment_configuration['password'])
        else
          raise UnsupportedGatewayException.new("Unsupported Gateway Exception, you provided #{payment_configuration['gateway']}
                                                and the supported gateways are 'bogus' and 'authorize_net'")
        end
      end
    end
  end
end
