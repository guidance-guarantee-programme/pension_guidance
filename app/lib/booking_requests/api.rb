module BookingRequests
  class Api
    def create(booking_request)
      response = connection.post '/api/v1/booking_requests', booking_request
      response.body
    rescue HTTPConnection::UnprocessableEntity
      false
    end

    def slots(location_id)
      response = connection.get "/api/v1/locations/#{location_id}/bookable_slots"
      response.body
    end

    private

    def connection
      HTTPConnectionFactory.build(api_uri, connection_options).tap do |c|
        c.headers[:accept] = 'application/json'
        c.authorization :Bearer, bearer_token if bearer_token
      end
    end

    def connection_options
      {
        timeout: read_timeout,
        open_timeout: open_timeout,
        retries: retries
      }
    end

    def open_timeout
      ENV.fetch('BOOKING_REQUESTS_API_OPEN_TIMEOUT', 2).to_i
    end

    def read_timeout
      ENV.fetch('BOOKING_REQUESTS_API_READ_TIMEOUT', 2).to_i
    end

    def retries
      ENV.fetch('BOOKING_REQUESTS_API_RETRIES', 0).to_i
    end

    def bearer_token
      ENV['BOOKING_REQUESTS_API_BEARER_TOKEN']
    end

    def api_uri
      ENV.fetch('BOOKING_REQUESTS_API_URI', 'http://localhost:3002')
    end
  end
end
