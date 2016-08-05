module Locations
  Location = Struct.new(:id, :name, :address, :booking_location_id, :phone, :hours, :twilio_number, :lat_lng)
end
