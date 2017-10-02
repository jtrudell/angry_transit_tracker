require 'test_helper'

class BusDirectionsFetcherTest < ActiveSupport::TestCase
  test "#execute creates Directions" do
    resp = {
      "bustime-response": {
        "directions": [
          {
            "dir": "Northbound"
          },
          {
            "dir": "Southbound"
          }
        ]
      }
    }.to_json

    bus_route = BusRoute.create(external_id: '555', name: 'My Aweomse Bus')

    BusDirectionsFetcher.stub(:cta_api_request, resp) do
      BusDirectionsFetcher.execute(bus_route)
      assert_equal 2, Direction.count
      assert_equal ["Southbound", "Northbound"].sort,  Direction.all.map(&:direction).sort
      assert_equal Direction.all.map(&:id).sort, bus_route.directions.map(&:id).sort
    end
  end
end
