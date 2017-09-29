require 'test_helper'

class BusRouteTest < ActiveSupport::TestCase
  # TODO: add tests for validations

  test "from_json factory" do
    params = {
      rt: "1",
      rtnm: "Bronzeville/Union Station",
      rtclr: "#336633",
      rtdd: "1"
    }

    bus_route = BusRoute.from_json(params)
    assert_equal "1", bus_route.external_id
    assert_equal "Bronzeville/Union Station", bus_route.name
  end

  test "#display_name" do
    bus_route = BusRoute.create(external_id: "300", name: "Somewhere")
    assert_equal "300 - Somewhere", bus_route.display_name
  end
end
