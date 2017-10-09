require 'test_helper'

class DirectionSerializerTest < ActiveSupport::TestCase
  test "serializer" do
    bus_route = BusRoute.create(external_id: '555', name: 'My Awesome Bus')
    direction = Direction.new(bus_route_id: bus_route.id, direction: 'Southbound')
    serializer = DirectionSerializer.new(direction)

    expected = {
      "direction"=> {
         :id=>nil,
         :direction=>'Southbound',
         :bus_route_id=>bus_route.id
      }
    }

    assert_equal expected.to_json, serializer.to_json
  end
end
