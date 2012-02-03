class AddCreditCardInformationToCustomers < ActiveRecord::Migration
  def change
    add_column :jackpot_customers, :credit_card_expiry_month,  :integer
    add_column :jackpot_customers, :credit_card_expiry_year,   :integer
    add_column :jackpot_customers, :credit_card_token,         :string
  end
end
