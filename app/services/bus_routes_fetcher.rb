class BusRoutesFetcher
  require 'net/http'
  CTA_API_KEY = Rails.application.secrets.api_key
  CTA_BUS_URL = 'http://www.ctabustracker.com/bustime/api/v2/getroutes'.freeze

  def self.execute
    resp = cta_api_request
    routes = JSON.parse(resp)['bustime-response']['routes']
    routes.map { |route| BusRoute.from_json(route.symbolize_keys) }
  end

  def self.cta_api_request
    uri = URI(CTA_BUS_URL + "?key=#{CTA_API_KEY}&format=json")
    Net::HTTP.get(uri)
  end
end
