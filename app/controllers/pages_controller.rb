class PagesController < ApplicationController
  def home
    @bus_routes = BusRoute.all
  end
end
