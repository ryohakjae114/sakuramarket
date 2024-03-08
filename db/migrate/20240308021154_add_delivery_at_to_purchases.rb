class AddDeliveryAtToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :delivery_at, :date
  end
end
