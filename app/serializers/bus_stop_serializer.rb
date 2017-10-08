class BusStopSerializer < ActiveModel::Serializer
  attributes \
    :id,
    :stop_id,
    :name,
    :direction,
    :display_name,
    :created_at,
    :updated_at

  has_many :bus_routes

  private

  def display_name
    object.display_name
  end
end
