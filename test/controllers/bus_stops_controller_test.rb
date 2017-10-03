require 'test_helper'

class BusStopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    bus_route = BusRoute.create(external_id: "1", name: "Foo")
    get bus_route_bus_stops_path(bus_route_id: bus_route.id)
    assert_response :success
  end

  test "should get show" do
    bus_route = BusRoute.create(external_id: "1", name: "Foo")
    bus_stop = bus_route.bus_stops.create(stop_id: "1", name: "Foo", direction: "Northbound")
    get bus_route_bus_stop_path(bus_route_id: bus_route.id, id: bus_stop.id)
    assert_response :success
  end
end
