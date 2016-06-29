module BookingLocations
  class Slot < OpenStruct
    def to_calendar
      ["#{calendar_date} - #{period}", "#{date}-#{start}-#{self.end}"]
    end

    def calendar_date
      Date.parse(date).strftime('%A, %b %e')
    end

    def period
      start == '0900' ? 'Morning' : 'Afternoon'
    end
  end
end
