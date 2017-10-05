require 'net/http'

class BusStopsFetcher
  CTA_API_KEY = Rails.application.secrets.api_key
  CTA_STOP_URL = 'http://www.ctabustracker.com/bustime/api/v2/getstops'.freeze

  def self.execute(route, direction)
    resp = cta_api_request(route, direction)
    stops = JSON.parse(resp)['bustime-response']['stops']
    stops.map do |stop|
      stop = BusStop.from_json(stop.symbolize_keys.merge(direction: direction))
      route.bus_stops << stop if stop.persisted?
    end
  end

  def self.cta_api_request(route, direction)
    uri = URI(CTA_STOP_URL + "?key=#{CTA_API_KEY}&rt=#{route.external_id}&dir=#{direction}&format=json")
    Net::HTTP.get(uri)
  end
end
