class ChangeAmountType < ActiveRecord::Migration[5.0]
  def change
    change_column :ingredients, :amount, :decimal
  end
end
