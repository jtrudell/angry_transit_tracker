require 'test_helper'

class DirectionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    bus_route = BusRoute.create(external_id: '1', name: 'Foo')
    get bus_route_directions_path(bus_route_id: bus_route.id)
    assert_response :success
  end
end
