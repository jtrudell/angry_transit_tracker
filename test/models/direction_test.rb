require 'test_helper'

class DirectionTest < ActiveSupport::TestCase
  test "from_json factory" do
    params = {
      bus_route_id: 1,
      dir: "Southbound"
    }

    direction = Direction.from_json(params)
    assert_equal 1, direction.bus_route_id
    assert_equal 'Southbound', direction.direction
  end

  test 'valid direction' do
    bus_route = BusRoute.create(external_id: '555', name: 'My Aweomse Bus')
    direction = Direction.new(direction: 'Northbound', bus_route_id: bus_route.id)
    assert direction.valid?
  end

  test 'invalid without direction' do
    bus_route = BusRoute.create(external_id: '555', name: 'My Aweomse Bus')
    direction = Direction.new(bus_route_id: bus_route.id)
    assert direction.invalid?
    assert_equal ["can't be blank", "is not included in the list"], direction.errors[:direction]
  end

  test 'invalid without bus_route_id' do
    direction = Direction.new(direction: 'Northbound')
    assert direction.invalid?
    assert_equal ["can't be blank"], direction.errors[:bus_route_id]
  end

  test 'invalid without a direction matching options' do
    bus_route = BusRoute.create(external_id: '555', name: 'My Aweomse Bus')
    direction = Direction.new(direction: 'Downtown', bus_route_id: bus_route.id)
    assert direction.invalid?
    assert_equal ["is not included in the list"], direction.errors[:direction]
  end
end
