module WelshLanguage
  class Api
    def locations
      response = connection.get('/api/v1/locations')
      response.body
    end

    def create_booking(booking_request)
      response = connection.post('/api/v1/booking_requests', booking_request)
      response.success?
    end

    private

    def connection
      HTTPConnectionFactory.build(api_uri, **connection_options).tap do |c|
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
      ENV.fetch('ALTERNATIVE_API_OPEN_TIMEOUT', 2).to_i
    end

    def read_timeout
      ENV.fetch('ALTERNATIVE_API_READ_TIMEOUT', 2).to_i
    end

    def retries
      ENV.fetch('ALTERNATIVE_API_RETRIES', 0).to_i
    end

    def api_uri
      ENV.fetch('ALTERNATIVE_API_URI', 'http://localhost:3010')
    end
  end
end
