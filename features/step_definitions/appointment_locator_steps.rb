When(/^I search for appointment locations near to a valid postcode$/) do
  postcode = 'BT7 3AP'  # Belfast
  lat_lng = double(latitude: 54.597269, longitude: -5.930109)
  geocoder = double

  allow(Postcodes::IO).to receive(:new).and_return(geocoder)
  allow(geocoder).to receive(:lookup).with(postcode).and_return(lat_lng)

  Pages::Locations.new.load(postcode: postcode)
end

Then(/^I should see the (\d+) appointment locations nearest to that postcode$/) do |_number_of_locations|
  page_locations = Pages::Locations.new.locations

  expected_locations = ['London', 'Paris', 'New York']
  expect(page_locations.map(&:name).map(&:text)).to eq(expected_locations)

  distances = page_locations.map(&:distance).map(&:text).map do |distance|
    /\b(.+?) miles/.match(distance)[1].to_f
  end
  expect(distances).to eq(distances.sort)
end
