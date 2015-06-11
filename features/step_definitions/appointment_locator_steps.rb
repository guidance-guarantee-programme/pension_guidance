When(/^I search for appointment locations near to a valid postcode$/) do
  locations = 1.upto(7).map { |x| Locations::Location.new("cab-#{x}", [1, 0]) }
  search_results = locations.map.with_index { |l, i| Locations::SearchResult.new(l, i) }
  postcode = 'SW1A 2HQ'
  lat_lng = [1, 0]
  limit = 5

  allow(Locations::Repository).to receive(:all).and_return(locations)
  allow(Geocoder).to receive(:coordinates).with(postcode).and_return(lat_lng)
  allow(Locations::Search).to receive(:nearest_to).with(
    locations, lat_lng, limit).and_return(search_results.take(limit))

  Pages::Locations.new.load(postcode: postcode)
end

Then(/^I should see the (\d+) appointment locations nearest to that postcode$/) do |number_of_locations|
  expected_locations = number_of_locations.to_i.times.map { |i| "cab-#{i + 1}" }
  expected_distances = number_of_locations.to_i.times.map { |i| "#{i} miles" }

  page_locations = Pages::Locations.new.locations

  expect(page_locations.map(&:name).map(&:text)).to eq(expected_locations)
  expect(page_locations.map(&:distance).map(&:text)).to eq(expected_distances)
end
