class AddSubscriptionAndCustomerToJackpotPayments < ActiveRecord::Migration
  def change
    change_table :jackpot_payments do |t|
      t.references :subscription 
      t.references :customer 
    end 
  end
end
