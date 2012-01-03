module Jackpot
  class Customer < ActiveRecord::Base
    belongs_to :subscription
  end
end
