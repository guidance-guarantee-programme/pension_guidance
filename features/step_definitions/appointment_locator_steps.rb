Given(/^I have searched for appointment locations near to a valid postcode$/) do
  step('I search for appointment locations near to a valid postcode')
end

When(/^I search for appointment locations near to a valid postcode$/) do
  postcode = 'BT7 3AP'  # Belfast

  VCR.use_cassette('locations_search') do
    Pages::Locations.new.load(postcode: postcode)
  end
end

Given(/^I have drilled down into a specific search result$/) do
  step('I drill down into a specific search result')
end

When(/^I drill down into a specific search result$/) do
  location = Pages::Locations.new.locations.first
  location.name.click
end

When(/^I view the details of an appointment location that handles its own booking$/) do
  Pages::Location.new.load(id: 'london')
end

Given(/^I have bookmarked the page$/) do
  @bookmark = page.driver.current_url
end

When(/^I search for appointment locations near to an invalid postcode$/) do
  postcode = 'invalid'

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

Then(/^I should be informed that Pension Wise cannot find that postcode$/) do
  expect(Pages::Locations.new).to have_invalid_postcode
end

Then(/^I should see the details of that appointment location$/) do
  location = Pages::Location.new

  expect(location).to be_displayed(id: 'london')
  expect(location.name.text).to eq('London')

  %i(address phone hours).each do |element|
    expect(location.public_send(element)).to be_visible
  end
end

When(/^I visit the bookmarked page$/) do
  page.driver.visit(@bookmark)
end

Then(/^I should see the following appointment location details:$/) do |table|
  location = Pages::Location.new

  table.rows.flatten.each do |detail|
    attribute, value = case detail
                       when 'its name'
                         [:name, 'London']
                       when 'its address'
                         [:address, '1 Horse Guards Road, SW1A 2HQ']
                       when 'its opening hours'
                         [:hours, 'Mon-Fri 9-5']
                       when 'its Pension Wise booking phone number'
                         [:phone, '123 456']
                       end
    expect(location.public_send(attribute)).to have_content(value)
  end
end
