class AddCodesToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :codes, :integer, array: true, default: []
  end
end
