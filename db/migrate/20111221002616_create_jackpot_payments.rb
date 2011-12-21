class CreateJackpotPayments < ActiveRecord::Migration
  def change
    create_table :jackpot_payments do |t|
      t.string :token

      t.timestamps
    end
  end
end
