# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def seed_bus_routes
  BusRoutesFetcher.execute
end

def seed_bus_directions
  BusRoute.all.each do |route|
    BusDirectionsFetcher.execute(route)
  end
end

def seed_bus_stops
  BusRoute.all.each do |route|
    route.directions.each do |direction|
      BusStopFetcher.execute(route, direction)
    end
  end
end

seed_bus_routes
seed_bus_directions
# seed_bus_stops
