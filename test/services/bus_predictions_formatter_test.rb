require 'test_helper'

class BusPredictionsFormatterTest < ActiveSupport::TestCase
  # test "#execute creates BusStops" do
  #   resp = {
  #     "bustime-response": {
  #       "stops": [
  #         {
  #           "stpid": "1",
  #           "stpnm": "My Corner",
  #         },
  #         {
  #           "stpid": "2",
  #           "stpnm": "Some Other Corner",
  #         }
  #       ]
  #     }
  #   }.to_json
  #
  #   bus_route = BusRoute.create(external_id: '555', name: 'My Aweomse Bus')
  #   direction = Direction.create(direction: 'Eastbound', bus_route_id: bus_route.id)
  #
  #   BusStopsFetcher.stub(:cta_api_request, resp) do
  #     BusStopsFetcher.execute(bus_route, direction)
  #     assert_equal 2, BusStop.count
  #     assert_equal ['My Corner', 'Some Other Corner'].sort, BusStop.all.map(&:name).sort
  #     assert_equal BusStop.all.map(&:id).sort, bus_route.bus_stops.map(&:id).sort
  #   end
  # end
end
