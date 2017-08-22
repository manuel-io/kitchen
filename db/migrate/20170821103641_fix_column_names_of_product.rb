class FixColumnNamesOfProduct < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :roughage, :fiber
    rename_column :products, :salt, :natrium
  end
end
