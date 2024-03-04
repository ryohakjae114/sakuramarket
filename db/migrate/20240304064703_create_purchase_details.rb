class CreatePurchaseDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_details do |t|
      t.references :purchase, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
