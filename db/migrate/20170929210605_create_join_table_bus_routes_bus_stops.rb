class CreateJoinTableBusRoutesBusStops < ActiveRecord::Migration[5.1]
  def change
    create_join_table :bus_routes, :bus_stops do |t|
      t.index [:bus_route_id, :bus_stop_id]
      # t.index [:bus_stop_id, :bus_route_id]
    end
  end
end
