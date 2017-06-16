class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :sources, :recipe_id_id, :recipe_id
  end
end
