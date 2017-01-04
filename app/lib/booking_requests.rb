module BookingRequests
  cattr_accessor :api

  def self.create(booking_request)
    payload = ApiMapper.map(booking_request)

    api.create(payload)
  end
end
