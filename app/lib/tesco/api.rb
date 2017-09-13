module Tesco
  class Api
    def create(booking)
      response = connection.post(
        "/api/v1/locations/#{booking.location_id}/appointments",
        booking.attributes
      )

      booking.id = parse_response_location(response)
    rescue HTTPConnection::UnprocessableEntity
      false
    end

    def locations
      response = connection.get('/api/v1/locations')
      response.body
    end

    def location(location_id)
      response = connection.get("/api/v1/locations/#{location_id}")
      response.body
    end

    private

    def parse_response_location(response)
      location = response.headers['Location']
      location.split('/').last
    end

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
      ENV.fetch('TESCO_API_OPEN_TIMEOUT', 2).to_i
    end

    def read_timeout
      ENV.fetch('TESCO_API_READ_TIMEOUT', 2).to_i
    end

    def retries
      ENV.fetch('TESCO_API_RETRIES', 0).to_i
    end

    def api_uri
      ENV.fetch('TESCO_API_URI', 'http://localhost:3008')
    end
  end
end
