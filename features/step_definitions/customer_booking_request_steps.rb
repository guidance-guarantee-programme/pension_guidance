Given(/^a location is enabled for online booking$/) do
  Locations.online_booking_location_uids = %w(ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef)
end

Given(/^no locations are enabled for online booking$/) do
  Locations.online_booking_location_uids = []
end

Given(/^the date is (.*)$/) do |date|
  @date = Date.parse(date)
  Timecop.travel @date
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

When(/^I choose three available appointment slots$/) do
  @step_one = Pages::BookingStepOne.new
  expect(@step_one).to be_displayed

  @step_one.wait_for_available_days
  expect(@step_one).to have_available_days

  # select the morning and afternoon slots on the first day
  @step_one.available_days.first.click
  @step_one.morning_slot.click
  @step_one.afternoon_slot.click

  # select the morning slot on the last day
  @step_one.available_days.last.click
  @step_one.morning_slot.click

  @step_one.continue.click
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
