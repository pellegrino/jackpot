class AddDescriptionToJackpotSubscriptions < ActiveRecord::Migration
  def change
    add_column :jackpot_subscriptions, :description, :text
  end
end
