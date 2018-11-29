module Locations
  class Location
    include ActiveModel::Model

    attr_accessor :id,
                  :name,
                  :address,
                  :booking_location_id,
                  :phone,
                  :hours,
                  :twilio_number,
                  :online_booking_enabled,
                  :lat_lng,
                  :realtime

    alias realtime? realtime

    def online_booking_enabled?
      online_booking_enabled
    end

    def online_booking_disabled?
      !online_booking_enabled
    end

    def slots
      @slots ||= BookingRequests.slots(id)
    end

    def realtime_slots?
      return false unless realtime?

      slots.any?(&:realtime?)
    end

    def no_availability?
      slots.empty?
    end

    def slots_available?
      !no_availability?
    end

    def limited_availability?
      online_booking_enabled? && slots_available? && slots.size < 3
    end

    def postcode
      address.split("\n").last
    end
  end
end
