class LocationDecorator < SimpleDelegator
  def initialize(location, booking_location: nil, nearest_locations: nil, twilio_number: nil)
    __setobj__(location)

    self._booking_location = booking_location
    self.nearest_locations = nearest_locations
    self.twilio_number = twilio_number
  end

  def phone
    return formated_twilio_number unless twilio_number.nil?
    return _booking_location.phone unless _booking_location.nil?

    super
  end

  def hours
    _booking_location.nil? ? super : _booking_location.hours
  end

  def booking_location
    _booking_location.nil? ? nil : _booking_location.name
  end

  def position
    return unless index.present?

    index + 1
  end

  def distance
    return unless index.present?

    format('%.2f', nearest_locations[index].distance)
  end

  private

  attr_accessor :_booking_location, :nearest_locations, :twilio_number

  def formated_twilio_number
    Phoner::Phone.parse(twilio_number).format('%A %n')
  end

  def index
    return unless nearest_locations.present?

    @index ||= nearest_locations.index { |location| location.id == id }
  end
end
