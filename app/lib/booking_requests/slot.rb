require 'ostruct'

module BookingRequests
  class Slot < OpenStruct
    def to_calendar
      ["#{calendar_date} - #{period}", "#{date}-#{start}-#{self.end}"]
    end

    def calendar_date
      Date.parse(date).strftime('%A, %b %e')
    end

    def period
      if windowed?
        start == '0900' ? 'Morning' : 'Afternoon'
      else
        Time.zone.parse("#{date} #{start.dup.insert(2, ':')}").strftime('%-I:%M%P')
      end
    end

    def realtime?
      !windowed?
    end

    def windowed?
      self.end.to_i - start.to_i == 400
    end
  end
end
