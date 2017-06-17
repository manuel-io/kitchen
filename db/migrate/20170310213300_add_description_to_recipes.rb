class AddDescriptionToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :description, :text
    add_column :recipes, :last, :date
  end
end
