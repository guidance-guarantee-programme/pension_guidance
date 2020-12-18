module Bsl
  class Mapper
    def initialize(booking_request)
      @booking_request = booking_request
    end

    def call # rubocop:disable MethodLength, AbcSize
      {
        first_name: booking_request.first_name,
        last_name: booking_request.last_name,
        email: booking_request.email,
        phone: booking_request.phone,
        memorable_word: booking_request.memorable_word,
        date_of_birth: booking_request.date_of_birth,
        defined_contribution_pot_confirmed: booking_request.defined_contribution_pot_confirmed,
        accessibility_needs: booking_request.accessibility_needs,
        additional_info: booking_request.additional_info,
        where_you_heard: booking_request.where_you_heard,
        gdpr_consent: booking_request.gdpr_consent.to_s,
        support: booking_request.supported,
        support_name: booking_request.support_name,
        support_relationship: booking_request.support_relationship,
        support_email: booking_request.support_email,
        support_phone: booking_request.support_phone
      }
    end

    private

    attr_reader :booking_request
  end
end
