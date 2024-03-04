class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :paid_at
      t.datetime :delivery_at

      t.timestamps
    end
  end
end
