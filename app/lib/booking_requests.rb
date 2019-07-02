module BookingRequests
  cattr_accessor :api

  def self.create(booking_request)
    payload = ApiMapper.map(booking_request)

    api.create(payload)
  end

  def self.slots(location_id)
    api.slots(location_id)
  end
end
