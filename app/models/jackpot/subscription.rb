module Jackpot

  # Represents a subscription that is billed every month.
  class Subscription < ActiveRecord::Base
    has_many :customers
    has_many :payments

    validates_presence_of :name
    

    # Charge the subscriber the price of this subscription, using its saved credit card token
    def charge(customer_to_be_charged)
      payments.create(:customer => customer_to_be_charged)
    end 

    # Returns the price formatted in units
    def price
      (price_in_cents / 100.0) unless price_in_cents.nil?
    end 

    # Returns the raw price stored, in cents 
    def price_in_cents
      read_attribute(:price) 
    end 

  end
end
