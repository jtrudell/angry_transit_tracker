require 'test_helper'

class BusRoutesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    bus_route = BusRoute.create(external_id: "1", name: "Foo")
    get bus_route_path(bus_route.id)
    assert_response :success
  end
end
