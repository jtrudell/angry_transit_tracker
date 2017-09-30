class BusRoute < ApplicationRecord
  has_many :directions
  has_and_belongs_to_many :bus_stops
  validates_presence_of :external_id, :name
  validates_uniqueness_of :external_id

  def self.from_json(**params)
    external_id = params[:rt]
    name = params[:rtnm]
    BusRoute.where(external_id: external_id).first_or_create(external_id: external_id, name: name)
  end

  def display_name
    "#{external_id} - #{name}"
  end
end
