class RemoveTitleFromConnection < ActiveRecord::Migration[5.1]
  def change
    remove_column :connections, :title, :string
  end
end
