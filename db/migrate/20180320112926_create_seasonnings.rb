class CreateSeasonnings < ActiveRecord::Migration[5.1]
  def change
    create_table :seasonnings do |t|
      t.string :title
      t.decimal :amount
      t.decimal :price

      t.timestamps
    end
  end
end
