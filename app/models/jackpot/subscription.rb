module Jackpot
  class Subscription < ActiveRecord::Base
    has_many :customers
  end
end
