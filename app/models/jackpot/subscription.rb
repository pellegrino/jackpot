module Jackpot
  class Subscription < ActiveRecord::Base
    has_many :customers
    has_many :payments

    validates_presence_of :name
  end
end
