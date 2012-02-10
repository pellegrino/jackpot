require_relative 'errors'

module Jackpot
  class Cron

    def initialize(customer_storage, logger)
      @customer_storage = customer_storage
      @logger           = logger
    end 

    def run
      overdue_customers = @customer_storage.overdue
      overdue_customers.each do |c|
        begin 
          c.pay_subscription
        rescue Jackpot::Error => e
          @logger.error "Something was wrong when trying to process #{c} payment. Exception was #{e}"
        end 
      end 
    end 
  end 
end 
