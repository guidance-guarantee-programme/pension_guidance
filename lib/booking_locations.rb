module BookingLocations
  cattr_accessor :api

  def self.find(id)
    api.get(id) do |response_hash|
      Location.new(response_hash)
    end
  end
end
