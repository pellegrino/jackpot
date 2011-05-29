module Jackpot
  module Payment

    module Gateways

      class Bogus
        require 'active_merchant'

        def initialize(params={})
          @gateway =  ActiveMerchant::Billing::BogusGateway.new
        end

        def purchase(amount, credit_card, options={})
          @gateway.purchase(amount, credit_card, options)
        end

        def recurring(amount, credit_card, recurring_options)
          @gateway.recurring(amount, credit_card, recurring_options)
        end
      end

    end

  end
end
