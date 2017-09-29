require 'test_helper'

class BusRoutesFetcherTest < ActiveSupport::TestCase
  test "#execute creates BusRoutes" do
    resp = {
      "bustime-response": {
      "routes": [
        {
          "rt": "1",
          "rtnm": "Bronzeville/Union Station",
          "rtclr": "#336633",
          "rtdd": "1"
        },
        {
          "rt": "2",
          "rtnm": "Somewhere",
          "rtclr": "#ffffff",
          "rtdd": "5"
        }

      ]
      }
    }.to_json

    BusRoutesFetcher.stub(:cta_api_request, resp) do
      BusRoutesFetcher.execute
      assert_equal 2, BusRoute.count
      assert_equal "2", BusRoute.second.external_id
      assert_equal "Somewhere", BusRoute.second.name

    end
  end
end
