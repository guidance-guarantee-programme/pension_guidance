Around('@booking_requests') do |_, block|
  begin
    previous_api = BookingRequests.api
    BookingRequests.api = BookingRequests::StubApi.new
    block.call
  ensure
    BookingRequests.api = previous_api
  end
end
