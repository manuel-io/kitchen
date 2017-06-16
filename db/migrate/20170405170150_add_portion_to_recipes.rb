class AddPortionToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :portion, :integer
  end
end
