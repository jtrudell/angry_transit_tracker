class BusStopsController < ApplicationController
  def index
    @bus_route
    @bus_stops = bus_route.bus_stops
  end

  def show
    @bus_stop
    raw_predictions = fetch_predictions
    @predictions = format(raw_predictions)
  end

  private
  def bus_route
    @bus_route ||= BusRoute.find(params.require(:bus_route_id))
  end

  def bus_stop
    @bus_stop ||= BusStop.find(params.require(:id))
  end

  def fetch_predictions
    BusPredictionsFetcher.execute(bus_route, bus_stop)
  end

  # THIS IS AN AWFUL WIP
  def format(raw_predictions)
    if raw_predictions['error']
      error = raw_predictions['error'].first
      error['stop number'] = error.delete('stpid')
      error['route'] = error.delete('rt')
      error['message'] = error.delete('msg')
      error
    else
      prediction = raw_predictions['prd'].first
      formatted_prediction = {}
      formatted_prediction['route'] = prediction['rt']
      formatted_prediction['stop number'] = prediction['stpid']
      formatted_prediction['minutes'] = prediction['prdctdn']
      formatted_prediction['arrival time'] = prediction['prdtm'].to_datetime.strftime("%I:%M%p on %m/%d/%Y")
      formatted_prediction['delayed'] = prediction['dly']
      formatted_prediction['distance'] = prediction['dstp'].to_s + " feet away"
      formatted_prediction['vehicle id'] = prediction['vid']
      formatted_prediction
    end
  end
end
