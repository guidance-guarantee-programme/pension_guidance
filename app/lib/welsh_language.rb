require_relative 'welsh_language/api'

module WelshLanguage
  module_function

  def locations
    api = WelshLanguage::Api.new
    api.locations.map { |location| OpenStruct.new(location) }
  end

  def create_booking(booking_request)
    api = WelshLanguage::Api.new
    api.create_booking(booking_request.payload)
  end
end
