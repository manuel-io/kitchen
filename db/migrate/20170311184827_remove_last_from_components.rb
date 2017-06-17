class RemoveLastFromComponents < ActiveRecord::Migration[5.0]
  def change
    remove_column :components, :last
  end
end
