Given(/^a location enabled for online booking$/) do
  Locations.online_booking_location_uids = %w(ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef)
end

Given(/^no locations are enabled for online booking$/) do
  Locations.online_booking_location_uids = []
end

When(/^I browse for the location$/) do
  with_booking_locations do
    @page = Pages::Location.new
    @page.load(id: 'ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef')
  end
end

Then(/^I can book online$/) do
  expect(@page.book_online).to be_visible
end

Then(/^I cannot book online$/) do
  expect(@page).to have_no_book_online
end

When(/^I opt to book online$/) do
  @page.book_online.click
end

When(/^I choose a minimum of two available appointment slots$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I provide my personal details$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I pass the basic eligibility requirements$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^my Booking Request is confirmed$/) do
  pending # express the regexp above with the code you wish you had
end

def with_booking_locations
  previous_path = Locations.geo_json_path_or_url
  Locations.geo_json_path_or_url = Rails.root.join(*%w(features fixtures booking_locations.json))

  yield
ensure
  Locations.geo_json_path_or_url = previous_path
end
