Given(/^I have searched for appointment locations near to a valid postcode$/) do
  step('I search for appointment locations near to a valid postcode')
end

When(/^I search for appointment locations near to a valid postcode$/) do
  postcode = 'BT7 3AP' # Belfast

  @page = Pages::LocationSearch.new
  @page.load(locale: :en)
  @page.postcode.set(postcode)
  @page.submit.click
end

Given(/^I have drilled down into a specific search result$/) do
  step('I drill down into a specific search result')
end

When(/^I drill down into a specific search result$/) do
  location = Pages::Locations.new.locations.first
  location.link_to.click
end

When(/^I visit a face to face booking location page$/) do
  step('I view the details of an appointment location that handles its own booking')
end

When(/^I view the details of an appointment location that handles its own booking$/) do
  Pages::Location.new.load(locale: :en, id: 'london')
end

When(/^I search for appointment locations near to an invalid postcode$/) do
  postcode = 'invalid'

  @page = Pages::LocationSearch.new
  @page.load(locale: :en)
  @page.postcode.set(postcode)
  @page.submit.click
end

When(/^I search for appointment locations without entering a postcode$/) do
  @page = Pages::LocationSearch.new
  @page.load(locale: :en)
  @page.postcode.set('')
  @page.submit.click
end

When(/^I view the details of an appointment location that doesn't handle its own booking$/) do
  Pages::Location.new.load(locale: :en, id: 'paris')
end

Then(/^I should see the (\d+) appointment locations nearest to that postcode$/) do |_number_of_locations|
  page_locations = Pages::Locations.new.locations

  expected_locations = ['London', 'Hackney', 'Paris', 'New York']
  expected_addresses = [
    '1 Horse Guards Road SW1A 2HQ',
    'Hackney Citizens Advice 300 Mare St Hackney London E8 1HE',
    '35 Rue du Faubourg Saint-Honoré 75008 Paris',
    'Manhattan NY 10036 United States'
  ]

  expect(page_locations.map(&:name).map(&:text)).to eq(expected_locations)
  expect(page_locations.map(&:address).map(&:text)).to eq(expected_addresses)

  distances = page_locations.map(&:distance).map(&:text).map do |distance|
    /\b(.+?) miles/.match(distance)[1].to_f
  end
  expect(distances).to eq(distances.sort)
end

Then(/^I should be informed that Pension Wise cannot find that postcode$/) do
  expect(Pages::Locations.new).to have_invalid_postcode
end

Then(/^I am told to enter a valid postcode$/) do
  expect(Pages::Locations.new).to have_empty_postcode_error
end

Then(/^I should see the details of that appointment location$/) do
  location = Pages::Location.new

  expect(location).to be_displayed(id: 'london')
  expect(location.name.text).to eq('London')
  expect(location.accessibility_information).to have_text('Lift is temporarily out of action')

  %i(address phone).each do |element|
    expect(location.public_send(element)).to be_visible
  end

  expect(location.breadcrumbs.map(&:text)).to eq([
                                                   'Home',
                                                   'Book a free appointment',
                                                   'Find an appointment location near you'
                                                 ])
end

# rubocop:disable Metrics/BlockLength
Then(/^I should see the following appointment location details:$/) do |table|
  location = Pages::Location.new

  if table.rows.flatten.include?('booking location Pension Wise booking phone number')
    table.rows.flatten.each do |detail|
      attribute, value = case detail
                         when 'its name'
                           [:name, 'Paris']
                         when 'its address'
                           [:address, '35 Rue du Faubourg Saint-Honoré 75008 Paris']
                         when 'booking location opening hours'
                           [:hours, 'Mon-Fri 8-6']
                         when 'booking location Pension Wise booking phone number'
                           [:phone, '0113 3333333']
                         end
      expect(location.public_send(attribute)).to have_content(value)
    end
  else
    table.rows.flatten.each do |detail|
      attribute, value = case detail
                         when 'its name'
                           [:name, 'London']
                         when 'its address'
                           [:address, '1 Horse Guards Road SW1A 2HQ']
                         when 'its opening hours'
                           [:hours, 'Mon-Fri 9-5']
                         when 'its Pension Wise booking phone number'
                           [:phone, '01234 56789']
                         end
      expect(location.public_send(attribute)).to have_content(value)
    end
  end
end
# rubocop:enable Metrics/BlockLength
