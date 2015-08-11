class LocationDecorator < SimpleDelegator
  def initialize(location, booking_location: nil, twilio_number: nil)
    __setobj__(location)
    self._booking_location = booking_location
    self.twilio_number = twilio_number
  end

  def phone
    return twilio_number unless twilio_number.nil?
    return _booking_location.phone unless _booking_location.nil?
    super
  end

  def hours
    _booking_location.nil? ? super : _booking_location.hours
  end

  def booking_location
    _booking_location.nil? ? nil : _booking_location.name
  end

  private

  attr_accessor :_booking_location, :twilio_number
end
