module BookingRequestsHelper
  def confirmation(booking_request)
    key = booking_request.realtime? ? 'appointment_completed' : 'booking_completed'

    t("booking_requests.#{key}.html")
  end

  def slot_as_formatted_date(slot_text)
    Date.parse(slot_properties(slot_text)[:date]).strftime('%A, %b %e')
  end

  def slot_period(slot_text)
    BookingRequests::Slot.new(slot_properties(slot_text)).period
  end

  def slot_duration
    '45 to 60 minutes'
  end

  private

  def slot_properties(slot_text)
    date, from, to = slot_text.match(/\A(\d{4}-\d{2}-\d{2})-(\d{4})-(\d{4})\z/).captures

    {
      date: date,
      start: from,
      end: to
    }
  end
end
