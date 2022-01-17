module BookingRequests
  class StubApi
    def create(*payload)
      Rails.logger.info(payload)

      {
      }
    end

    def slots(*)
      {}.tap do |result|
        (Date.current..2.weeks.from_now.to_date).reject(&:on_weekend?).each do |date|
          result[date.iso8601] = [
            "#{date.iso8601} 09:00:00 UTC",
            "#{date.iso8601} 10:00:00 UTC",
            "#{date.iso8601} 11:00:00 UTC",
            "#{date.iso8601} 12:00:00 UTC",
            "#{date.iso8601} 13:00:00 UTC"
          ]
        end
      end
    end
  end
end
