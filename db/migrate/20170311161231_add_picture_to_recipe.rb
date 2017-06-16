class AddPictureToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :picture, :binary, :limit => 5.megabyte
  end
end
