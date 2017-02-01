class TelephoneAppointmentsApi
  def create(telephone_appointment)
    connection.post('/api/v1/appointments', telephone_appointment.attributes)
    true
  rescue HTTPConnection::UnprocessableEntity
    false
  end

  def slots
    response = connection.get('/api/v1/bookable_slots')
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
    ENV.fetch('TAP_APPOINTMENTS_API_OPEN_TIMEOUT', 2)
  end

  def read_timeout
    ENV.fetch('TAP_APPOINTMENTS_API_READ_TIMEOUT', 2)
  end

  def retries
    ENV.fetch('TAP_APPOINTMENTS_API_RETRIES', 0)
  end

  def api_uri
    ENV.fetch('TAP_APPOINTMENTS_API_URI', 'http://localhost:3000')
  end

  def bearer_token
    ENV.fetch('TAP_APPOINTMENTS_API_BEARER_TOKEN', nil)
  end
end