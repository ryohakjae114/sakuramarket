class RenameDeliveryAtColumnToPurchases < ActiveRecord::Migration[7.1]
  def change
    rename_column :purchases, :delivery_at, :delivery_on
  end
end
