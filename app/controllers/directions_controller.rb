class DirectionsController < ApplicationController
  def index
    @directions = bus_route.directions
    render json: @directions
  end

  private

  def bus_route
    @bus_route ||= BusRoute.find(params.require(:bus_route_id))
  end
end
