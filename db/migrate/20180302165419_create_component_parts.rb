class CreateComponentParts < ActiveRecord::Migration[5.1]
  def change
    create_table :component_parts do |t|
      t.string :title
      t.text :description
      t.references :recipe, foreign_key: true
      t.references :part, polymorphic: true

      t.timestamps
    end
  end
end