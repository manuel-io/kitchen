class AddDescriptionToComponent < ActiveRecord::Migration[5.0]
  def change
    add_column :components, :description, :text
  end
end
