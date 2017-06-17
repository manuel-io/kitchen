class RemoveAnnotationFromComponents < ActiveRecord::Migration[5.0]
  def change
    remove_column :components, :annotation
  end
end
