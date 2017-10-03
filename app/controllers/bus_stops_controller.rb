class BusStopsController < ApplicationController
  def index
    @bus_route = bus_route
    @bus_stops = bus_route.bus_stops
  end

  def show
    @bus_stop = bus_stop
    @predictions = BusPredictionsFetcher.execute(bus_route, bus_stop)
  end

  private
  def bus_route
    BusRoute.find(params.require(:bus_route_id))
  end

  def bus_stop
    BusStop.find(params.require(:id))
  end
end
