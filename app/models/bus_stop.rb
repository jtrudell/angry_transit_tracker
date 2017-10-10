class BusStop < ApplicationRecord
  has_and_belongs_to_many :bus_routes
  validates_presence_of :stop_id, :name, :direction
  validates_uniqueness_of :stop_id

  scope :by_direction, ->(direction) { where(direction: direction) }

  def self.from_json(**params)
    stop_id = params[:stpid]
    name = params[:stpnm]
    direction = params[:direction]
    BusStop.where(stop_id: stop_id, direction: direction)
           .first_or_create(stop_id: stop_id, name: name, direction: direction)
  end

  def display_name
    "#{stop_id}: #{name} (#{direction})"
  end
end
