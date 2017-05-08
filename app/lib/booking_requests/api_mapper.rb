module BookingRequests
  module ApiMapper
    def self.map(booking_request) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      {
        booking_request: {
          booking_location_id: booking_request.booking_location_id,
          location_id: booking_request.location_id,
          name: "#{booking_request.first_name} #{booking_request.last_name}",
          email: booking_request.email,
          phone: booking_request.telephone_number,
          memorable_word: booking_request.memorable_word,
          age_range: booking_request.appointment_type,
          date_of_birth: booking_request.date_of_birth.iso8601,
          accessibility_requirements: booking_request.accessibility_requirements,
          marketing_opt_in: booking_request.opt_in,
          defined_contribution_pot_confirmed: dc_pot_as_boolean(booking_request.dc_pot),
          slots: [
            slot(1, booking_request.primary_slot),
            booking_request.secondary_slot.present? ? slot(2, booking_request.secondary_slot) : nil,
            booking_request.tertiary_slot.present? ? slot(3, booking_request.tertiary_slot) : nil
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

    def self.dc_pot_as_boolean(dc_pot)
      dc_pot == 'yes'
    end
  end
end
