class BusStopsController < ApplicationController
  def index
    @route_name = route_name
    @bus_stops = bus_stops_scope
    respond_to do |format|
      format.html
      format.json { render json: @bus_stops }
    end
  end

  def show
    @route_name = route_name
    @predictions = fetch_predictions
  end

  private

  def bus_route
    @bus_route ||= BusRoute.find(params.require(:bus_route_id))
  end

  def bus_stop
    @bus_stop ||= BusStop.find(params.require(:id))
  end

  def bus_stops_scope
    if params[:direction]
      bus_route.bus_stops.by_direction(params[:direction])
    else
      bus_route.bus_stops
    end
  end

  def route_name
    bus_route.display_name
  end

  def fetch_predictions
    raw_predictions = BusPredictionsFetcher.execute(bus_route, bus_stop)
    BusPredictionsFormatter.new(raw_predictions).execute
  end
end
