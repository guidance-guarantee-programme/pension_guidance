When(/^I search for appointment locations near to a valid postcode$/) do
  postcode = 'SW1A 2HQ'

  allow(Locations).to receive(:nearest_to_postcode).with(postcode, limit: 5) do
    1.upto(5).map { |x| Locations::Location.new("cab-#{x}") }
  end

  Pages::Locations.new.load(postcode: postcode)
end

Then(/^I should see the (\d+) appointment locations nearest to that postcode$/) do |number_of_locations|
  expected_locations = number_of_locations.to_i.times.map { |i| "cab-#{i + 1}" }
  expect(Pages::Locations.new.locations.map(&:name).map(&:text)).to eq(expected_locations)
end
