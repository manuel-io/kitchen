class RemoveTitleFromComponent < ActiveRecord::Migration[5.1]
  def change
    remove_column :components, :title, :string
    remove_column :components, :description, :text
  end
end
