class CreateComponents < ActiveRecord::Migration[5.0]
  def change
    create_table :components do |t|
      t.string :title
      t.date :last

      t.timestamps
    end
  end
end
