class AddSubtitleToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :subtitle, :string
  end
end
