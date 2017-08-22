class AddVitaminAb9ToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :a, :decimal
    add_column :products, :b9, :decimal
  end
end
