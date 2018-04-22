class RemoveScaleFromVegetables < ActiveRecord::Migration[5.1]
  def change
    remove_column :vegetables, :scale, :decimal
  end
end
