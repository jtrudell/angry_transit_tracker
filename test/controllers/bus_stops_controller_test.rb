require 'test_helper'

class BusStopsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get bus_stops_show_url
    assert_response :success
  end

end
