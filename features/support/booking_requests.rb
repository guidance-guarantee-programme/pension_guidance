Around('@booking_requests') do |_, block|
  begin
    previous_api = BookingRequests.api
    BookingRequests.api = BookingRequests::StubApi.new
    block.call
  ensure
    BookingRequests.api = previous_api
  end
end

Around('@no_availability') do |_, block|
  begin
    previous_api = BookingRequests.api

    BookingRequests.api = Class.new do
      def slots(*)
        []
      end
    end.new

    block.call
  ensure
    BookingRequests.api = previous_api
  end
end
