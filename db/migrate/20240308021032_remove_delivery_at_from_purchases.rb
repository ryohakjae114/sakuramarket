class RemoveDeliveryAtFromPurchases < ActiveRecord::Migration[7.1]
  def change
    remove_column :purchases, :delivery_at, :datetime
  end
end
