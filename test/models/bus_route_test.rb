require 'test_helper'

class BusRouteTest < ActiveSupport::TestCase
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

  test 'valid bus route' do
    bus_route = BusRoute.new(external_id: '555', name: 'My Awesome Bus')
    assert bus_route.valid?
  end

  test 'invalid without external_id' do
    bus_route = BusRoute.new(name: 'My Aweomse Bus')
    assert bus_route.invalid?
    assert_equal ["can't be blank"], bus_route.errors[:external_id]
  end

  test 'invalid without name' do
    bus_route = BusRoute.new(external_id: '555')
    assert bus_route.invalid?
    assert_equal ["can't be blank"], bus_route.errors[:name]
  end

  test 'invalid if external_id not uniuqe' do
    bus_route = BusRoute.create(external_id: '555', name: 'My Aweomse Bus')
    bus_route = BusRoute.new(external_id: '555', name: 'Party Bus')
    assert bus_route.invalid?
    assert_equal ["has already been taken"], bus_route.errors[:external_id]
  end

  test "#display_name" do
    bus_route = BusRoute.create(external_id: "300", name: "Somewhere")
    assert_equal "300 - Somewhere", bus_route.display_name
  end

  test "#as_json" do
    bus_route = BusRoute.create(external_id: "300", name: "Somewhere")
    direction = bus_route.directions.create(direction: "Northbound")
    stop = bus_route.bus_stops.create(stop_id: "200", name: "Wacker and Monroe", direction: "Northbound")

    json = {
      "id" => bus_route.id,
      "external_id" => "300",
      "name" => "Somewhere",
      "directions"=>[
        {"id"=> direction.id,
         "direction"=> direction.direction,
         "bus_route_id"=> direction.bus_route_id,
         "created_at"=> direction.created_at,
         "updated_at"=> direction.updated_at
      }],
      "bus_stops"=>[
        {"id"=> stop.id,
         "stop_id"=> stop.stop_id,
         "name"=> stop.name,
         "direction"=> stop.direction,
         "created_at"=> stop.created_at,
         "updated_at"=> stop.updated_at
      }]
    }

    assert_equal json['id'], bus_route.as_json['id']
    assert_equal json['directions'], bus_route.as_json['directions']
    assert_equal json['bus_stops'], bus_route.as_json['bus_stops']
  end
end
