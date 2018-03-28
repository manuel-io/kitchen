class RemoveAmountFromIngredient < ActiveRecord::Migration[5.1]
  def change
    remove_column :vegetables, :amount, :decimal
  end
end
