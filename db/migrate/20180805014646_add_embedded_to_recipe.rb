class AddEmbeddedToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :embedded, :boolean
  end
end
