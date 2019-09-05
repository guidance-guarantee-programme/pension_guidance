class TelephoneAppointmentsApi
  def create(telephone_appointment)
    response = connection.post('/api/v1/appointments', telephone_appointment.attributes)

    telephone_appointment.id = parse_response_location(response)
  rescue HTTPConnection::UnprocessableEntity
    false
  end

  def slots
    response = connection.get('/api/v1/bookable_slots')
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
    ENV.fetch('TAP_APPOINTMENTS_API_OPEN_TIMEOUT', 2).to_i
  end

  def read_timeout
    ENV.fetch('TAP_APPOINTMENTS_API_READ_TIMEOUT', 2).to_i
  end

  def retries
    ENV.fetch('TAP_APPOINTMENTS_API_RETRIES', 0).to_i
  end

  def api_uri
    ENV.fetch('TAP_APPOINTMENTS_API_URI', 'http://localhost:3000')
  end

  def bearer_token
    ENV.fetch('TAP_APPOINTMENTS_API_BEARER_TOKEN', nil)
  end
end
