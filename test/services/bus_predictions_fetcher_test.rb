require 'test_helper'

class BusPredictionsFetcherTest < ActiveSupport::TestCase
  test "#execute fetches bus time predictions" do
    resp = {
      "bustime-response"=> {
         "prd"=>
         [
           {
            "tmstmp"=>"20171006 11:57",
            "typ"=>"A",
            "stpnm"=>"My Awesome Bus Stop",
            "stpid"=>"333",
            "vid"=>"1268",
            "dstp"=>3160,
            "rt"=>"24",
            "rtdd"=>"555",
            "rtdir"=>"Southbound",
            "des"=>"79th Red Line",
            "prdtm"=>"20171006 12:00",
            "tablockid"=>"24 -703",
            "tatripid"=>"1086804",
            "dly"=>false,
            "prdctdn"=>"2",
            "zone"=>""
           }
         ]
      }
    }.to_json

    bus_route = BusRoute.create(external_id: '555', name: 'My Awesome Bus')
    bus_stop = bus_route.bus_stops.create(stop_id: '333', name: 'My Awesome Bus Stop')
    expected_response = JSON.parse(resp)['bustime-response']

    BusPredictionsFetcher.stub(:cta_api_request, resp) do
      assert_equal expected_response, BusPredictionsFetcher.execute(bus_route, bus_stop)
    end
  end
end
