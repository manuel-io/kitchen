class ChangeNameToTitle < ActiveRecord::Migration[5.1]
  def change
    rename_column :sources, :name, :title
  end
end
