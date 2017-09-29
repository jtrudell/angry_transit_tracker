class CreateBusStops < ActiveRecord::Migration[5.1]
  def change
    create_table :bus_stops do |t|
      t.string :stop_id
      t.string :name

      t.timestamps
    end
  end
end
