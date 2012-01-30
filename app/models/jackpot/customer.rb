module Jackpot
  class Customer < ActiveRecord::Base
    belongs_to      :subscription
    attr_protected  :credit_card_number
    attr_protected  :credit_card_expiry_year
    attr_protected  :credit_card_expiry_month
    
    attr_accessor   :credit_card_verification_value
    

    def update_credit_card(card_hash) 
      original_number = card_hash["number"]
      write_attribute  :credit_card_number            , "XXXX-XXXX-XXXX-#{original_number.last(4)}"
      write_attribute  :credit_card_expiry_month      ,  card_hash["month"] 
      write_attribute  :credit_card_expiry_year       ,  card_hash["year"] 
      write_attribute  :credit_card_verification_value,  card_hash["verification_value"] 
      save
    end 

    def expiration_date
      "#{credit_card_expiry_month}/#{credit_card_expiry_year}"
    end 

  end
end
