class ChangeIngredient2 < ActiveRecord::Migration[5.1]
  def change
    add_reference :ingredients, :adding, polymorphic: true
  end
end
