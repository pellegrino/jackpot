class AddBillingPeriodToJackpotSubscriptions < ActiveRecord::Migration
  def change
    add_column :jackpot_subscriptions, :billing_period, :integer
  end
end
