class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :image
      t.integer :price_without_tax
      t.text :description
      t.boolean :displayed, default: false, null: false
      t.integer :position

      t.timestamps
    end
  end
end
