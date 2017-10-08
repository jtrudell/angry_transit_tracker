require 'net/http'

class BusPredictionsFetcher
  CTA_API_KEY = Rails.application.secrets.api_key
  CTA_PREDICTION_URL = 'http://www.ctabustracker.com/bustime/api/v2/getpredictions'.freeze

  def self.execute(route, stop)
    resp = cta_api_request(route, stop)
    JSON.parse(resp)['bustime-response']
  end

  def self.cta_api_request(route, stop)
    uri = URI(CTA_PREDICTION_URL + "?key=#{CTA_API_KEY}&rt=#{route.external_id}&stpid=#{stop.stop_id}&format=json")
    Net::HTTP.get(uri)
  end
end
