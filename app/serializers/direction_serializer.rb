class DirectionSerializer < ActiveModel::Serializer
  attributes \
    :id,
    :direction,
    :bus_route_id
end
