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
          defined_contribution_pot_confirmed: dc_pot_as_boolean(booking_request.dc_pot),
          additional_info: booking_request.additional_info.to_s,
          where_you_heard: booking_request.where_you_heard,
          gdpr_consent: booking_request.gdpr_consent.to_s,
          slots: [
            slot(booking_request.start_at)
          ]
        }
      }
    end

    def self.slot(start_at)
      date = start_at.to_date.to_fs(:db)
      from = start_at.dup.to_fs(:time).sub(':', '')
      to   = start_at.dup.advance(hours: 1).to_fs(:time).sub(':', '')

      { priority: 1, date: date, from: from, to: to }
    end

    def self.dc_pot_as_boolean(dc_pot)
      dc_pot == 'yes'
    end
  end
end
