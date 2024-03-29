module Locations
  class Location
    include ActiveModel::Model

    attr_accessor :id,
                  :name,
                  :address,
                  :accessibility_information,
                  :booking_location_id,
                  :phone,
                  :hours,
                  :twilio_number,
                  :online_booking_enabled,
                  :lat_lng

    def accessibility_information?
      accessibility_information.present?
    end

    def online_booking_enabled?
      online_booking_enabled
    end

    def online_booking_disabled?
      !online_booking_enabled
    end

    def slots
      @slots ||= BookingRequests.slots(id)
    end

    def hidden_booking_location?
      booking_location_id.blank? && no_availability?
    end

    def no_availability?
      slots.empty?
    end

    def slots_available?
      !no_availability?
    end

    def limited_availability?
      online_booking_enabled? && slots_available? && slots.values.flatten.size < 3
    end

    def postcode
      address.split("\n").last
    end
  end
end
