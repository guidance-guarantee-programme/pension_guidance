module WithStubBookingRequestsApi
  def with_stubbed_booking_requests_api(api, example)
    previous_api = BookingRequests.api
    BookingRequests.api = api

    example.run
  ensure
    BookingRequests.api = previous_api
  end
end

RSpec.configure do |config|
  config.include WithStubBookingRequestsApi
end
