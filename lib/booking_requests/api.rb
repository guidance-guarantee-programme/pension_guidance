module BookingRequests
  class Api
    def create(booking_request)
      connection.post '/api/v1/booking_requests', booking_request

      true
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
      ENV.fetch('BOOKING_REQUESTS_API_OPEN_TIMEOUT', 10)
    end

    def read_timeout
      ENV.fetch('BOOKING_REQUESTS_API_READ_TIMEOUT', 10)
    end

    def retries
      ENV.fetch('BOOKING_REQUESTS_API_RETRIES', 0)
    end

    def bearer_token
      ENV['BOOKING_REQUESTS_API_BEARER_TOKEN']
    end

    def api_uri
      ENV.fetch('BOOKING_REQUESTS_API_URI', 'http://localhost:3002')
    end
  end
end
