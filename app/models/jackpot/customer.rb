module Jackpot
  class Customer < ActiveRecord::Base
    belongs_to      :subscription
    has_many        :payments, :through => :subscription  

    attr_protected  :credit_card_number
    attr_protected  :credit_card_expiry_year
    attr_protected  :credit_card_expiry_month
    attr_protected  :credit_card_token

    
    scope :due_in , lambda { |number_of_days| where("good_until <= ?", 
                                                    number_of_days.days.from_now) }

    # Returns customers that are overdue
    scope :overdue , lambda { due_in(-1) }

    # Returns every customer that has a card about to expire within the given period composed 
    # of today plus a number of months. Defaults to 3 months 
    #
    # number_of_months -> number of months from now. Default: 3  
    scope :with_expiring_card , lambda { |number_of_months=3| 
      cut_date = (Date.today + number_of_months.months).at_beginning_of_month
      where("credit_card_expiry_month <= ? AND credit_card_expiry_year <= ?", 
            cut_date.month, cut_date.year) 
    } 
    

    # Returns every customer with already expired cards 
    scope :with_expired_card, lambda { with_expiring_card(-1) }




    attr_accessor   :credit_card_verification_value

    def pay_subscription
      if credit_card_token   
        if subscription.present? && subscription.charge(self)
          update_attribute(:good_until, Date.today + 1.month)
        end 
      else 
        raise Jackpot::Errors::CustomerHasNoCardSaved.new
      end 
    end 
    

    def update_credit_card(card)  
      raise Errors::CardIsInvalid unless card.valid? 
      write_attribute  :credit_card_number            ,  card.masquerade_number
      write_attribute  :credit_card_expiry_month      ,  card.month
      write_attribute  :credit_card_expiry_year       ,  card.year

      # This should never be recorded 
      self.credit_card_verification_value = card.verification_value
      stored_card_response = Jackpot::Base.gateway.store(card)
      write_attribute :credit_card_token , stored_card_response.params["customer_vault_id"]

      save
    end 

    def expiration_date
      "#{credit_card_expiry_month}/#{credit_card_expiry_year}"
    end 


    # Checks if this customer's card will expire within the next :months. 
    # 
    # number_of_months -> Number of months within this card will expire. Defaults to 3 
    def expiring?(number_of_months=3)
      (Date.parse(expiration_date) - number_of_months.months) <= Date.today.at_beginning_of_month
    end 

  end
end
