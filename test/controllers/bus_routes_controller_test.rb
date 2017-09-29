require 'test_helper'

class BusRoutesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    BusRoute.create(external_id: "1", name: "Foo")
    get bus_routes_search_url, params: { bus_route: { external_id: "1"} }
    assert_response :success
  end
end
