class BusRouteSerializer < ActiveModel::Serializer
  attributes \
    :id,
    :external_id,
    :name,
    :display_name,
    :created_at,
    :updated_at

  has_many :directions
  has_many :bus_stops

  private

  def display_name
    object.display_name
  end
end
