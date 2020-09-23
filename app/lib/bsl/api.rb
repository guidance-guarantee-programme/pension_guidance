module Bsl
  class Api
    def create_booking(booking_request)
      response = connection.post('/api/v1/bsl_booking_requests', booking_request)
      response.success?
    end

    private

    def connection
      HTTPConnectionFactory.build(api_uri, connection_options).tap do |c|
        c.headers[:accept] = 'application/json'
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
      ENV.fetch('WELSH_API_OPEN_TIMEOUT', 2).to_i
    end

    def read_timeout
      ENV.fetch('WELSH_API_READ_TIMEOUT', 2).to_i
    end

    def retries
      ENV.fetch('WELSH_API_RETRIES', 0).to_i
    end

    def api_uri
      ENV.fetch('WELSH_API_URI', 'http://localhost:3010')
    end
  end
end
