require 'test_helper'

class BusRouteTest < ActiveSupport::TestCase
  test 'from_json factory' do
    params = {
      rt: '1',
      rtnm: 'Bronzeville/Union Station',
      rtclr: '#336633',
      rtdd: '1'
    }

    bus_route = BusRoute.from_json(params)
    assert_equal '1', bus_route.external_id
    assert_equal 'Bronzeville/Union Station', bus_route.name
  end

  test 'valid bus route' do
    bus_route = BusRoute.new(external_id: '555', name: 'My Awesome Bus')
    assert bus_route.valid?
  end

  test 'invalid without external_id' do
    bus_route = BusRoute.new(name: 'My Awesome Bus')
    assert bus_route.invalid?
    assert_equal ["can't be blank"], bus_route.errors[:external_id]
  end

  test 'invalid without name' do
    bus_route = BusRoute.new(external_id: '555')
    assert bus_route.invalid?
    assert_equal ["can't be blank"], bus_route.errors[:name]
  end

  test 'invalid if external_id not unique' do
    BusRoute.create(external_id: '555', name: 'My Awesome Bus')
    bus_route = BusRoute.new(external_id: '555', name: 'Party Bus')
    assert bus_route.invalid?
    assert_equal ['has already been taken'], bus_route.errors[:external_id]
  end

  test 'has many directions' do
    bus_route = BusRoute.create(external_id: '555', name: 'My Awesome Bus')
    direction = Direction.create(bus_route_id: bus_route.id, direction: 'Northbound')
    Direction.create(bus_route_id: bus_route.id, direction: 'Southbound')
    assert_equal 2, bus_route.directions.count
    assert_equal direction.id, bus_route.directions.first.id
  end

  test '#display_name' do
    bus_route = BusRoute.create(external_id: '300', name: 'Somewhere')
    assert_equal '300 - Somewhere', bus_route.display_name
  end

  test '#as_json' do
    bus_route = BusRoute.create(external_id: '300', name: 'Somewhere')
    direction = bus_route.directions.create(direction: 'Northbound')
    stop = bus_route.bus_stops.create(stop_id: '200', name: 'Wacker and Monroe', direction: 'Northbound')

    assert_equal bus_route.id, bus_route.as_json['id']
    assert_equal '300', bus_route.as_json['external_id']
    assert_equal 'Northbound', bus_route.as_json['directions'].first['direction']
    assert_equal bus_route.id, bus_route.as_json['directions'].first['bus_route_id']
    assert_equal stop.id, bus_route.as_json['bus_stops'].first['id']
    assert_equal 'Wacker and Monroe', bus_route.as_json['bus_stops'].first['name']
    assert_equal 'Northbound', bus_route.as_json['bus_stops'].first['direction']
    assert_equal stop.created_at, bus_route.as_json['bus_stops'].first['created_at']
  end
end
