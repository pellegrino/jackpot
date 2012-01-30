module Jackpot
  class Customer < ActiveRecord::Base
    belongs_to      :subscription
    attr_protected  :credit_card_number

    def update_credit_card_number(card_hash) 
      original_number = card_hash[:number]
      write_attribute(:credit_card_number, "XXXX-XXXX-XXXX-#{original_number.last(4)}")
      save
    end 
  end
end
