class AddManufacturerToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :manufacturer, :string
    add_column :products, :shop, :string
    add_column :products, :code, :string
  end
end
