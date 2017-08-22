class AddDietTableToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :energy, :decimal
    add_column :products, :protein, :decimal
    add_column :products, :fat_total, :decimal
    add_column :products, :fat_saturated, :decimal
    add_column :products, :carbohydrate, :decimal
    add_column :products, :sugar, :decimal
    add_column :products, :magnesium, :decimal
    add_column :products, :calcium, :decimal
    add_column :products, :potassium, :decimal
    add_column :products, :iron, :decimal
    add_column :products, :zinc, :decimal
    add_column :products, :iodine, :decimal
    add_column :products, :omega3, :decimal
    add_column :products, :selenium, :decimal
    add_column :products, :roughage, :decimal
    add_column :products, :salt, :decimal
    add_column :products, :folic, :decimal
    add_column :products, :b1, :decimal
    add_column :products, :b2, :decimal
    add_column :products, :b3, :decimal
    add_column :products, :b5, :decimal
    add_column :products, :b6, :decimal
    add_column :products, :b12, :decimal
    add_column :products, :c, :decimal
    add_column :products, :d2, :decimal
    add_column :products, :e, :decimal
    add_column :products, :h, :decimal
    add_column :products, :k, :decimal
  end
end
