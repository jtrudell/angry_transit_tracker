class BusRoutesController < ApplicationController
  def show
    @bus_route = BusRoute.find(params.require(:id))
  end
end
