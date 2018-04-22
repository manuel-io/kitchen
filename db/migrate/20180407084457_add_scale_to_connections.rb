class AddScaleToConnections < ActiveRecord::Migration[5.1]
  def change
    add_column :connections, :scale, :decimal
  end
end
