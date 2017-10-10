require 'test_helper'

class BusStopSerializerTest < ActiveSupport::TestCase
  test "serializer" do
    bus_stop = BusStop.new(stop_id: '555', name: 'My Awesome Bus Stop', direction: 'Northbound')
    serializer = BusStopSerializer.new(bus_stop)

    expected = {
      "bus_stop"=> {
         :id=>nil,
         :stop_id=>"555",
         :name=>"My Awesome Bus Stop",
         :direction=>"Northbound",
         :display_name=>"555: My Awesome Bus Stop (Northbound)",
         :created_at=>nil,
         :updated_at=>nil
      }
    }

    assert_equal expected.to_json, serializer.to_json
  end
end
