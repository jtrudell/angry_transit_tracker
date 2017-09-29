class BusStop < ApplicationRecord
  has_and_belongs_to_many :bus_routes
  validates_presence_of :stop_id, :name
  validates_uniqueness_of :stop_id

  def self.from_json(**params)
    stop_id = params[:stpid]
    name = params[:stpnm]
    BusStop.where(stop_id: stop_id).first_or_create(stop_id: stop_id, name: name)
  end
end
