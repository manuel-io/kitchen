class ChangeRecipeToChildInConnection < ActiveRecord::Migration[5.1]
  def change
    rename_column :connections, :recipe_id, :child_id
  end
end
