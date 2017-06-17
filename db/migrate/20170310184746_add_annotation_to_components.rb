class AddAnnotationToComponents < ActiveRecord::Migration[5.0]
  def change
    add_column :components, :annotation, :string
  end
end
