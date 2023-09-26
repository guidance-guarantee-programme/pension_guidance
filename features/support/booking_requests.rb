Around('@no_availability') do |_, block|
  previous_api = BookingRequests.api

  BookingRequests.api = Class.new do
    def slots(*)
      {}
    end
  end.new

  block.call
ensure
  BookingRequests.api = previous_api
end

Around('@realtime_availability') do |_, block|
  previous_api = BookingRequests.api

  BookingRequests.api = Class.new do
    def slots(*)
      {
        '2018-11-06' => ['2018-11-06 09:00:00 UTC'],
        '2018-11-07' => ['2018-11-07 09:00:00 UTC'],
        '2018-11-08' => ['2018-11-08 09:00:00 UTC'],
        '2018-11-09' => ['2018-11-09 09:00:00 UTC'],
        '2018-11-10' => ['2018-11-10 09:00:00 UTC']
      }
    end

    def create(*)
      {
        'reference' => '1',
        'location' => 'Hackney',
        'proceeded_at' => '2018-11-21 13:00'
      }
    end
  end.new

  block.call
ensure
  BookingRequests.api = previous_api
end
