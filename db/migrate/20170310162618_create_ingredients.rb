class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.integer :amount
      t.string :unit
      t.string :name
      t.references :component, foreign_key: true

      t.timestamps
    end
  end
end
