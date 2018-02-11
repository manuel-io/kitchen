class RemoveCodesFromProduct < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :codes
  end
end
