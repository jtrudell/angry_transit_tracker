class BusPredictionsFetcher
  require 'net/http'
  CTA_API_KEY = Rails.application.secrets.api_key
  CTA_PREDICTION_URL = 'http://www.ctabustracker.com/bustime/api/v2/getpredictions'.freeze

  def self.execute(route, stop)
    resp = cta_api_request(route, stop)
    parsed_resp = JSON.parse(resp)['bustime-response']
    if parsed_resp['error']
      parsed_resp['error']
    else
      parsed_resp['prd']
    end
  end

  def self.cta_api_request(route, stop)
    uri = URI(CTA_PREDICTION_URL + "?key=#{CTA_API_KEY}&rt=#{route.external_id}&stpid=#{stop.stop_id}&format=json")
    Net::HTTP.get(uri)
  end
end
