class ChangeColumnNameFromRecipe < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipes, :portion, :serves
  end
end
