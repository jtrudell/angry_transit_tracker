require 'test_helper'

class BusRouteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
end
