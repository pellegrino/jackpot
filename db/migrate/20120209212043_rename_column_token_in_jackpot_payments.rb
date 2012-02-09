class RenameColumnTokenInJackpotPayments < ActiveRecord::Migration
  def change 
    rename_column :jackpot_payments, :token, :payment_transaction_token
  end 
end
