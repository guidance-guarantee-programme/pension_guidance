Given(/^a location is enabled for online booking$/) do
  @locations_path = %w(features fixtures locations_with_online_booking.json)
end

Given(/^no locations are enabled for online booking$/) do
  @locations_path = %w(features fixtures locations_without_online_booking.json)
end

When(/^I choose the first available realtime slot$/) do
  @step_one.wait_for_available_days
  @step_one.choose_date('2018-11-07')
  @step_one.choose_time('9:00am')
  @step_one.continue.click
end

Then(/^I see my one chosen slot$/) do
  @step_two = Pages::BookingStepTwo.new
  expect(@step_two).to have_chosen_slots(count: 1)
end

Then(/^my appointment is confirmed$/) do
  @page = Pages::BookingConfirmation.new
  expect(@page).to be_displayed
  expect(@page).to have_text('We’ve booked your appointment')
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
    @page.load(locale: :en, id: locations[location])
  end
end

Then(/^I can book online$/) do
  expect(@page).to have_book_online
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

When(/^I view the face to face booking form$/) do
  step('a location is enabled for online booking')
  step('I browse for the location "Hackney"')
  step('I opt to book online')
end

When(/^I choose one available appointment slot$/) do
  @step_one = Pages::BookingStepOne.new
  expect(@step_one).to be_displayed

  # wait for the slots to bind
  @step_one.wait_for_available_days
  expect(@step_one).to have_available_days

  # select the first available day and slot
  @step_one.choose_date('2016-06-20')
  @step_one.choose_time('9:00am')
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
  @step_two.accessibility_requirements.set false
  @step_two.where_you_heard.select 'Other'
  @step_two.gdpr_consent_yes.set true
end

When(/^I enter an email address with a typo$/) do
  with_mock_mailgun_response(
    is_valid: false,
    address: 'morty.sanchez@gmall.com',
    parts: {
      display_name: nil,
      local_part: 'morty.sanchez',
      domain: 'gmall.com'
    },
    did_you_mean: 'morty.sanchez@gmail.com'
  )

  @step_two = Pages::BookingStepTwo.new
  expect(@step_two).to be_displayed

  @step_two.email.set 'morty.sanchez@gmall.com'
  @step_two.telephone_number.click
end

When(/^I enter an invalid email address$/) do
  with_mock_mailgun_response(
    is_valid: false,
    address: 'morty.sanchez@totallyinvalid',
    parts: {
      display_name: nil,
      local_part: 'morty.sanchez',
      domain: 'totallyinvalid'
    },
    did_you_mean: nil
  )

  @step_two.email.set 'morty.sanchez@totallyinvalid'
  @step_two.telephone_number.click
end

When(/^I pass the basic eligibility requirements$/) do
  @step_two.date_of_birth_day.set '01'
  @step_two.date_of_birth_month.set '01'
  @step_two.date_of_birth_year.set '1950'
  @step_two.dc_pot_yes.set true
end

When(/^I provide ineligible details$/) do
  @step_two.date_of_birth_day.set '01'
  @step_two.date_of_birth_month.set '01'
  @step_two.date_of_birth_year.set '2010'
  @step_two.dc_pot_yes.set true
end

When(/^I submit my completed Booking Request$/) do
  @step_two.submit.click
end

Then(/^my Booking Request is confirmed$/) do
  @page = Pages::BookingConfirmation.new
  expect(@page).to be_displayed
  expect(@page).to have_text('We’ve received your booking request')
end

Then(/^I am told to choose further slots$/) do
  @step_two = Pages::BookingStepTwo.new
  expect(@step_two).to be_displayed
  expect(@step_two).to have_error
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
    f.wait_until_name_visible

    f.name.set 'Ben'
    f.email.set 'ben@example.com'
    f.message.set 'This is awesome!'
    f.submit.click
  end
end

Then(/^I see my feedback was sent$/) do
  expect(page).to have_content('Thank you for your help')
end

Then(/^I see a correction suggestion$/) do
  expect(@step_two.email_suggestion).to have_content('morty.sanchez@gmail.com')
end

Then(/^I see a warning of an invalid email address$/) do
  expect(@step_two).to have_content("That doesn't look like a valid address")
end

Then(/^I see a message to phone for availability$/) do
  expect(@step_one).to have_phone
end

def with_booking_locations
  previous_path = Locations.geo_json_path_or_url
  Locations.geo_json_path_or_url = Rails.root.join(*@locations_path)

  yield
ensure
  Locations.geo_json_path_or_url = previous_path
end
