class CreateJackpotPayments < ActiveRecord::Migration
  def change
    create_table :jackpot_payments do |t|
      t.string  :token
      t.integer :amount
      t.text    :description

      t.timestamps
    end
  end
end
