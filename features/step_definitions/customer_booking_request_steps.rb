Given(/^a location is enabled for online booking$/) do
  @locations_path = %w(features fixtures locations_with_online_booking.json)
end

Given(/^no locations are enabled for online booking$/) do
  @locations_path = %w(features fixtures locations_without_online_booking.json)
end

Given(/^the date is (.*)$/) do |date|
  @date = Date.parse(date)
  Timecop.travel @date
end

When(/^I browse for the location "([^"]*)"$/) do |location|
  locations = {
    'Hackney' => 'ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef',
    'Dalston' => '183080c6-642b-4b8f-96fd-891f5cd9f9c7'
  }

  with_booking_locations do
    @page = Pages::Location.new
    @page.load(id: locations[location])
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

Then(/^I see the location name "(.*?)"$/) do |name|
  @step_one = Pages::BookingStepOne.new
  expect(@step_one).to be_displayed

  expect(@step_one.location_name.text).to include(name)
end

Then(/^I see slots up to the day of closure$/) do
  expect(@step_one).to have_available_days(count: 1)
end

When(/^I view the face to face booking form$/) do
  step('a location is enabled for online booking')
  step('I browse for the location "Hackney"')
  step('I opt to book online')
end

When(/^I choose three available appointment slots$/) do
  @step_one = Pages::BookingStepOne.new
  expect(@step_one).to be_displayed

  # wait for the slots to bind
  @step_one.wait_for_available_days
  expect(@step_one).to have_available_days

  # select the morning slot on the first day
  @step_one.available_days.first.click
  @step_one.morning_slot.click

  # select the afternoon slot on the first day
  @step_one.available_days.first.click
  @step_one.afternoon_slot.click

  # select the morning slot on the last day
  @step_one.available_days.last.click
  @step_one.morning_slot.click

  # wait for the last slot to be confirmed
  @step_one.wait_for_last_chosen_slot
  @step_one.continue.click
end

When(/^I provide my personal details$/) do
  @step_two = Pages::BookingStepTwo.new
  expect(@step_two).to be_displayed

  @step_two.first_name.set 'Rick'
  @step_two.last_name.set 'Sanchez'
  @step_two.email.set 'rick@example.com'
  @step_two.telephone_number.set '07715 930 459'
  @step_two.memorable_word.set 'birdperson'
  @step_two.check_hidden_checkbox(@step_two.accessibility_requirements, true)
  @step_two.check_hidden_checkbox(@step_two.opt_in, true)
end

When(/^I pass the basic eligibility requirements$/) do
  @step_two.date_of_birth_day.set '01'
  @step_two.date_of_birth_month.set '01'
  @step_two.date_of_birth_year.set '1950'
  @step_two.check_hidden_radio(@step_two.dc_pot_yes)
end

When(/^I submit my completed Booking Request$/) do
  @step_two.submit.click
end

Then(/^my Booking Request is confirmed$/) do
  @confirmation = Pages::BookingConfirmation.new
  expect(@confirmation).to be_displayed
end

When(/^I choose one available appointment slot$/) do
  @step_one = Pages::BookingStepOne.new
  expect(@step_one).to be_displayed

  # wait for the calendar to bind
  @step_one.wait_for_available_days
  expect(@step_one).to have_available_days

  # choose only the first slot
  @step_one.available_days.first.click
  @step_one.morning_slot.click

  # wait for the slot to be confirmed and proceed
  @step_one.wait_for_first_chosen_slot
  @step_one.continue.click
end

Then(/^I am told to choose further slots$/) do
  @step_two = Pages::BookingStepTwo.new
  expect(@step_two).to be_displayed
  expect(@step_two).to have_error
end

When(/^I choose a further two appointment slots$/) do
  @step_one = Pages::BookingStepOne.new

  # wait for the calendar to bind
  @step_one.wait_for_available_days
  expect(@step_one).to have_available_days

  # choose the remaining two required slots
  @step_one.available_days.last.click
  @step_one.morning_slot.click

  @step_one.available_days.last.click
  @step_one.afternoon_slot.click

  # wait for slots to be confirmed and proceed
  @step_one.wait_for_last_chosen_slot
  @step_one.continue.click
end

Then(/^I progress to the personal details step$/) do
  @step_two = Pages::BookingStepTwo.new
  expect(@step_two).to be_displayed
  expect(@step_two).to_not have_error
end

When(/^I submit my incomplete Booking Request$/) do
  @step_two.submit.click
end

Then(/^I am told to complete my personal details$/) do
  @complete = Pages::BookingComplete.new
  expect(@complete).to be_displayed
  expect(@complete).to have_error
end

When(/^I go back$/) do
  @step_two = Pages::BookingStepTwo.new
  expect(@step_two).to be_displayed

  @step_two.back.click
end

Then(/^my chosen slots persist$/) do
  expect(@step_one).to be_displayed
  @step_one.wait_for_last_chosen_slot

  expect(@step_one).to have_first_chosen_slot
  expect(@step_one).to have_last_chosen_slot
end

When(/^I go forward$/) do
  @step_one.continue.click
end

Then(/^I am told I am ineligible for guidance$/) do
  @ineligible = Pages::BookingIneligible.new
  expect(@ineligible).to be_displayed
end

When(/^I complete the inline feedback$/) do
  @step_one = Pages::BookingStepOne.new
  expect(@step_one).to be_displayed

  @step_one.feedback.tap do |f|
    f.toggle.click
    f.wait_for_name

    f.name.set 'Ben'
    f.email.set 'ben@example.com'
    f.message.set 'This is awesome!'
    f.submit.click
  end
end

Then(/^I see my feedback was sent$/) do
  expect(page).to have_content('Thank you for your help')
end

def with_booking_locations
  previous_path = Locations.geo_json_path_or_url
  Locations.geo_json_path_or_url = Rails.root.join(*@locations_path)

  yield
ensure
  Locations.geo_json_path_or_url = previous_path
end
