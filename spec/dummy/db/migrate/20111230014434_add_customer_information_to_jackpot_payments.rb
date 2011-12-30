class AddCustomerInformationToJackpotPayments < ActiveRecord::Migration
  def change
    add_column :jackpot_payments, :customer_name, :string
  end
end
