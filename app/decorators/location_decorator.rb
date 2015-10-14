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

  def search_context
    @search_context ||= begin
      return unless nearest_locations.present?

      index = nearest_locations.index { |location| location.id == id }
      return unless index

      position = index + 1
      distance = format('%.2f', nearest_locations[index].distance)

      LocationSearchContext.new(position: position, distance: distance)
    end
  end

  private

  attr_accessor :_booking_location, :nearest_locations, :twilio_number

  def formated_twilio_number
    Phoner::Phone.parse(twilio_number).format('%A %n')
  end
end
