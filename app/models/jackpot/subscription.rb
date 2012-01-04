module Jackpot
  class Subscription < ActiveRecord::Base
    has_many :customers

    validates_presence_of :name
  end
end
