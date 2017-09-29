class CreateBusRoutes < ActiveRecord::Migration[5.1]
  def change
    create_table :bus_routes do |t|
      t.string :external_id
      t.string :name

      t.timestamps
    end
  end
end
