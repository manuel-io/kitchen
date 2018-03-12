class CreateConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :connections do |t|
      t.string :title
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
