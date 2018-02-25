class ChangeNameToTitleofIngredient < ActiveRecord::Migration[5.1]
  def change
    rename_column :ingredients, :name, :title
  end
end
