module BookingRequests
  module ApiMapper
    def self.map(booking_request) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      {
        booking_request: {
          location_id: booking_request.location_id,
          name: "#{booking_request.first_name} #{booking_request.last_name}",
          email: booking_request.email,
          phone: booking_request.telephone_number,
          memorable_word: booking_request.memorable_word,
          age_range: booking_request.appointment_type,
          accessibility_requirements: booking_request.accessibility_requirements,
          marketing_opt_in: booking_request.opt_in,
          defined_contribution_pot: booking_request.dc_pot,
          slots: [
            slot(1, booking_request.primary_slot),
            slot(2, booking_request.secondary_slot),
            slot(3, booking_request.tertiary_slot)
          ]
        }
      }
    end

    def self.slot(priority, slot_text)
      date, from, to = slot_text.match(/\A(\d{4}-\d{2}-\d{2})-(\d{4})-(\d{4})\z/).captures

      {
        priority: priority,
        date: date,
        from: from,
        to: to
      }
    end
  end
end
