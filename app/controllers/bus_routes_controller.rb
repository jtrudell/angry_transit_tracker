class BusRoutesController < ApplicationController
  def show
    @bus_route = BusRoute.find(params.require(:id))
  end

  def search
    @bus_route = BusRoute.find_by!(external_id: search_params[:external_id])
  end

  private
  def search_params
    params.require(:bus_route).permit(:external_id)
  end
end
