class AddRecipeToComponents < ActiveRecord::Migration[5.0]
  def change
    add_reference :components, :recipe
  end
end
