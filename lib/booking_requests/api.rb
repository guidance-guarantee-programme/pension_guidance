module BookingRequests
  class Api
    def create(booking_request)
      connection.post '/api/v1/booking_requests', booking_request

      true
    end

    private

    def connection
      HTTPConnectionFactory.build(api_uri).tap do |c|
        c.authorization :Bearer, bearer_token if bearer_token
      end
    end

    def bearer_token
      ENV['BOOKING_REQUESTS_API_BEARER_TOKEN']
    end

    def api_uri
      ENV.fetch('BOOKING_REQUESTS_API_URI', 'http://localhost:3002')
    end
  end
end
