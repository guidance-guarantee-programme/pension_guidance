class LocationDecorator < SimpleDelegator
  def initialize(location, booking_location = nil)
    __setobj__(location)
    self._booking_location = booking_location
  end

  def phone
    _booking_location.nil? ? super : _booking_location.phone
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
