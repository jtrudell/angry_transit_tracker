require 'test_helper'

class BusStopTest < ActiveSupport::TestCase
  test 'from_json factory' do
    params = {
      stpid: '333',
      stpnm: 'Ashland & Blackhawk',
      direction: 'Westbound'
    }

    bus_stop = BusStop.from_json(params)
    assert_equal '333', bus_stop.stop_id
    assert_equal 'Ashland & Blackhawk', bus_stop.name
    assert_equal 'Westbound', bus_stop.direction
  end

  test 'valid bus stop' do
    bus_stop = BusStop.new(stop_id: '555', name: 'Fifth and Third', direction: 'Northbound')
    assert bus_stop.valid?
  end

  test 'invalid without stop_id' do
    bus_stop = BusStop.new(name: 'Fifth and Third', direction: 'Northbound')
    assert bus_stop.invalid?
    assert_equal ["can't be blank"], bus_stop.errors[:stop_id]
  end

  test 'invalid without name' do
    bus_stop = BusStop.new(stop_id: '800', direction: 'Northbound')
    assert bus_stop.invalid?
    assert_equal ["can't be blank"], bus_stop.errors[:name]
  end

  test 'invalid without direction' do
    bus_stop = BusStop.new(stop_id: '800', name: 'Foobar')
    assert bus_stop.invalid?
    assert_equal ["can't be blank"], bus_stop.errors[:direction]
  end

  test 'invalid if stop_id not unique' do
    BusStop.create(stop_id: '555', name: 'Fifth and Third', direction: 'Northbound')
    bus_stop = BusStop.new(stop_id: '555', name: 'Foo Bar', direction: 'Southbound')
    assert bus_stop.invalid?
    assert_equal ['has already been taken'], bus_stop.errors[:stop_id]
  end

  test 'scope by_direction' do
    BusStop.create(stop_id: '555', name: 'Fifth and Third', direction: 'Northbound')
    bus_stop = BusStop.create(stop_id: '666', name: 'Foo Bar', direction: 'Southbound')
    assert_equal 1, BusStop.by_direction('Southbound').count
    assert_equal bus_stop, BusStop.by_direction('Southbound').first
  end
end
