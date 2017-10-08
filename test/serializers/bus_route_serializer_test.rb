require 'test_helper'

class BusRouteSerializerTest < ActiveSupport::TestCase
  test "serializer" do
    bus_route = BusRoute.new(external_id: '555', name: 'My Awesome Bus')
    serializer = BusRouteSerializer.new(bus_route)

    expected = {
      "bus_route"=> {
         :id=>nil,
         :external_id=>"555",
         :name=>"My Awesome Bus",
         :display_name=>"555 - My Awesome Bus",
         :created_at=>nil,
         :updated_at=>nil,
         :directions=>[],
         :bus_stops=>[]
      }
    }

    assert_equal expected.to_json, serializer.to_json
  end
end
