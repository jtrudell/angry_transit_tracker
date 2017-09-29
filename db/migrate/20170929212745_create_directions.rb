class CreateDirections < ActiveRecord::Migration[5.1]
  def change
    create_table :directions do |t|
      t.string :direction
      t.integer :bus_route_id

      t.timestamps
    end
  end
end
