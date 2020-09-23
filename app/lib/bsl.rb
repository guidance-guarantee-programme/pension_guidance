require_relative 'bsl/api'

module Bsl
  module_function

  def create_booking(booking_request)
    api = Bsl::Api.new
    api.create_booking(booking_request.payload)
  end
end
