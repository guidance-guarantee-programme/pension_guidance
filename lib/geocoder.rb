class Geocoder
  InvalidPostcode = Class.new(StandardError)

  def self.lookup(postcode)
    ukp = UKPostcode.parse(postcode)
    fail InvalidPostcode unless ukp.full_valid?

    lookup = Postcodes::IO.new.lookup(postcode)
    fail InvalidPostcode unless lookup

    [lookup.latitude, lookup.longitude]
  end
end
