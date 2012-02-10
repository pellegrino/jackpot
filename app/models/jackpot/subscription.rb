module Jackpot
  class Subscription < ActiveRecord::Base
    has_many :customers
    has_many :payments

    validates_presence_of :name
    

    def charge(customer_to_be_charged)
      payments.create(:customer => customer_to_be_charged)
    end 
  end
end
