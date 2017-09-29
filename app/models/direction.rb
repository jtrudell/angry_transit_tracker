class Direction < ApplicationRecord
  belongs_to :bus_route
  validates_presence_of :direction, :bus_route_id

  def self.from_json(**params)
    bus_route_id = params[:bus_route_id]
    direction = params[:dir]
    Direction.find_or_create_by(bus_route_id: bus_route_id, direction: direction)
  end
end
