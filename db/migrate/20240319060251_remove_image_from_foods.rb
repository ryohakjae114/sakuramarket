class RemoveImageFromFoods < ActiveRecord::Migration[7.1]
  def change
    remove_column :foods, :image, :string
  end
end
