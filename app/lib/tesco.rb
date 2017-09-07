module Tesco
  cattr_accessor :api

  def self.locations
    api.locations.map { |location| Location.new(location) }
  end

  def self.slots(location_id)
    api.slots(location_id).map { |slot| Slot.new(slot) }
  end
end
