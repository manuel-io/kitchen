class RemoveRecipeIdFromComponents < ActiveRecord::Migration[5.1]
  def change
    remove_reference :components, :recipe
  end
end
