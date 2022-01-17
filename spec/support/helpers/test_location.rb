class TestLocation
  def self.london
    Locations::Location.new(
      id: 'london',
      name: 'London',
      address: '',
      booking_location_id: '',
      phone: '',
      hours: '',
      twilio_number: '',
      online_booking_enabled: false,
      lat_lng: [51.500152, -0.126236]
    )
  end

  def self.paris
    Locations::Location.new(
      id: 'paris',
      name: 'Paris',
      address: '',
      booking_location_id: '',
      phone: '',
      hours: '',
      twilio_number: '',
      online_booking_enabled: false,
      lat_lng: [48.85666, 2.350987]
    )
  end

  def self.new_york
    Locations::Location.new(
      id: 'new-york',
      name: 'New York',
      address: '',
      booking_location_id: '',
      phone: '',
      hours: '',
      twilio_number: '',
      online_booking_enabled: false,
      lat_lng: [40.714269, 74.005973]
    )
  end
end
