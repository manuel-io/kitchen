class AddPublicToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :public, :boolean
  end
end
