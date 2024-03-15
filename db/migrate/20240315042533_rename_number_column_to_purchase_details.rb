class RenameNumberColumnToPurchaseDetails < ActiveRecord::Migration[7.1]
  def change
    rename_column :purchase_details, :number, :quantity
  end
end
