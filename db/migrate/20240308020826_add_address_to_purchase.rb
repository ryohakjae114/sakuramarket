class AddAddressToPurchase < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :address, :text
  end
end
