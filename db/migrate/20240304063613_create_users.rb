class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.text :address
      t.string :last_name
      t.string :first_name

      t.timestamps
    end
  end
end
