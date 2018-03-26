class ChangeComponent < ActiveRecord::Migration[5.1]
  def change
    add_reference :components, :adding, polymorphic: true
  end
end
