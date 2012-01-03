module Jackpot
  module CustomersHelper
    def subscription_name_when_available(customer)
      (customer.subscription.present?) ? customer.subscription.name : "-" 
    end 
  end
end
