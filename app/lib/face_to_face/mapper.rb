module FaceToFace
  class Mapper
    def initialize(booking)
      @booking = booking
    end

    def call # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      {
        first_name: booking.first_name,
        last_name: booking.last_name,
        email: booking.email,
        phone: booking.phone,
        memorable_word: booking.memorable_word,
        date_of_birth: booking.date_of_birth,
        defined_contribution_pot_confirmed: booking.defined_contribution_pot_confirmed,
        accessibility_requirements: booking.accessibility_requirements,
        adjustments: booking.adjustments,
        additional_info: booking.additional_info,
        where_you_heard: booking.where_you_heard,
        gdpr_consent: booking.gdpr_consent.to_s,
        support: booking.supported,
        support_name: booking.support_name,
        support_relationship: booking.support_relationship,
        support_email: booking.support_email,
        support_phone: booking.support_phone
      }
    end

    private

    attr_reader :booking
  end
end
