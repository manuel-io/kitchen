class AddTspAndTbspToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :tsp, :integer
    add_column :products, :tbsp, :integer
  end
end
