class AddProductToIngredient < ActiveRecord::Migration[5.0]
  def change
    add_reference :ingredients, :product
  end
end
