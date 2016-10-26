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
                  :lat_lng

    def online_booking_enabled?
      online_booking_enabled
    end
  end
end
