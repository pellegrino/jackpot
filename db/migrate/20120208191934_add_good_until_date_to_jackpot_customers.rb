class AddGoodUntilDateToJackpotCustomers < ActiveRecord::Migration
  def change
    add_column :jackpot_customers, :good_until, :date

  end
end
