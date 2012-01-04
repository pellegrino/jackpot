class AddCreditCardNumberToCustomer < ActiveRecord::Migration
  def change
    add_column :jackpot_customers, :credit_card_number, :string
  end
end
