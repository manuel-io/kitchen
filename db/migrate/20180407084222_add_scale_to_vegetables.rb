class AddScaleToVegetables < ActiveRecord::Migration[5.1]
  def change
    add_column :vegetables, :scale, :decimal
  end
end
