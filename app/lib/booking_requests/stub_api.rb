module BookingRequests
  class StubApi
    def create(*payload)
      Rails.logger.info(payload)

      {
        'reference' => '1',
        'proceeded_at' => '2018-11-21 13:00',
        'location' => 'Hackney'
      }
    end

    def slots(*)
      (Date.current..6.weeks.from_now.to_date).reject(&:on_weekend?).map do |date|
        [
          { date: date.iso8601, start: '0900', end: '1300' },
          { date: date.iso8601, start: '1300', end: '1700' }
        ]
      end.flatten
    end
  end
end
