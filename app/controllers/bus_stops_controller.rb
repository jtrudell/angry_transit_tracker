class BusStopsController < ApplicationController
  def index
    @bus_route = bus_route
    @bus_stops = bus_route.bus_stops
  end

  def show
    @bus_stop = BusStop.find(params.require(:id))
  end

  private
  def bus_route
    BusRoute.find(params.require(:bus_route_id))
  end
end
