class CreateJackpotSubscriptions < ActiveRecord::Migration
  def change
    create_table :jackpot_subscriptions do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
