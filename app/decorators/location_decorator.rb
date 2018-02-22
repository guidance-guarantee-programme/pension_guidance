class LocationDecorator < SimpleDelegator
  def initialize(location, booking_location: nil)
    __setobj__(location)

    self._booking_location = booking_location
  end

  def address_encoded
    @address_encoded ||= ERB::Util.url_encode(address.gsub("\n", ', ').squish)
  end

  def phone
    Phoner::Phone.parse(twilio_number)&.format('%A %n')
  end

  def hours
    _booking_location.nil? ? super : _booking_location.hours
  end

  def booking_location
    _booking_location.nil? ? nil : _booking_location.name
  end

  private

  attr_accessor :_booking_location
end
