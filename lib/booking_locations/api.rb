require 'open-uri'

module BookingLocations
  class Api
    def get(id)
      response = open("#{api_uri}/api/v1/booking_locations/#{id}.json", headers_and_options)
      yield JSON.parse(response.read)
    rescue OpenURI::HTTPError, Net::ReadTimeout
      nil
    end

    private

    def headers_and_options
      {}.tap do |hash|
        hash[:read_timeout]   = read_timeout
        hash['Authorization'] = "Bearer #{bearer_token}" if bearer_token
      end
    end

    def bearer_token
      ENV['BOOKING_LOCATIONS_API_BEARER_TOKEN']
    end

    def api_uri
      ENV.fetch('BOOKING_LOCATIONS_API_URI', 'http://localhost:3001')
    end

    def read_timeout
      ENV.fetch('BOOKING_LOCATIONS_API_READ_TIMEOUT', 5).to_i
    end
  end
end
