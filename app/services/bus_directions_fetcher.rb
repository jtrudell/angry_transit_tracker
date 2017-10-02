class BusDirectionsFetcher
  require 'net/http'
  CTA_API_KEY = Rails.application.secrets.api_key
  CTA_DIRECTION_URL = 'http://www.ctabustracker.com/bustime/api/v2/getdirections'.freeze

  def self.execute(route)
    resp = cta_api_request(route)
    directions = JSON.parse(resp)['bustime-response']['directions']
    directions.map do |direction|
      Direction.from_json(direction.symbolize_keys.merge(bus_route_id: route.id))
    end
  end

  def self.cta_api_request(route)
    uri = URI(CTA_DIRECTION_URL + "?key=#{CTA_API_KEY}&rt=#{route.external_id}&format=json")
    Net::HTTP.get(uri)
  end
end
