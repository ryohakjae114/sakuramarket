class AddDeliveryTimeZoneToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :delivery_time_zone, :string
  end
end
