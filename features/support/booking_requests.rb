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

Around('@realtime_availability') do |_, block|
  begin
    previous_api = BookingRequests.api

    BookingRequests.api = Class.new do
      def slots(*)
        [
          BookingRequests::Slot.new(date: '2018-11-06', start: '0900', end: '1000'),
          BookingRequests::Slot.new(date: '2018-11-07', start: '0900', end: '1000'),
          BookingRequests::Slot.new(date: '2018-11-08', start: '0900', end: '1000'),
          BookingRequests::Slot.new(date: '2018-11-09', start: '0900', end: '1000'),
          BookingRequests::Slot.new(date: '2018-11-10', start: '0900', end: '1000')
        ]
      end

      def create(*)
        true
      end
    end.new

    block.call
  ensure
    BookingRequests.api = previous_api
  end
end
