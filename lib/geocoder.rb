class Geocoder
  def self.lookup(postcode)
    lookup = Postcodes::IO.new.lookup(postcode)

    [lookup.latitude, lookup.longitude] if lookup
  end
end
