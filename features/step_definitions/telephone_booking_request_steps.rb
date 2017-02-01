Before do
  @appointment_api_fake = double(:telephone_appointment_api)

  allow(TelephoneAppointmentsApi).to receive(:new).and_return(@appointment_api_fake)
  allow(@appointment_api_fake).to receive(:slots).and_return(
    JSON.parse(File.read('features/fixtures/bookable_slots.json'))
  )
end

def stub_appointments_api_to_succeed
  allow(@appointment_api_fake).to receive(:create).once do |telephone_appointment|
    @created_telephone_appointment = telephone_appointment
    telephone_appointment.id = 'test-id'
    true
  end
end

def stub_appointments_api_to_fail
  allow(@appointment_api_fake).to receive(:create).once.and_return(false)
end

Given(/^the customer wants to book a phone appointment$/) do
  @page = Pages::NewTelephoneAppointment.new.tap(&:load)
  expect(@page).to be_displayed
end

def choose_date_and_time
  @page.find('button[value="2017-01-17"]').click
  @page.click_on('12:20pm')
end

Given(/^they do not have a DC pot$/) do
  choose_date_and_time

  @page.first_name.set 'First'
  @page.last_name.set 'Last'
  @page.email.set 'something@something.org'
  @page.phone.set '923902302'
  @page.memorable_word.set 'words'
  @page.date_of_birth_day.set '23'
  @page.date_of_birth_month.set '10'
  @page.date_of_birth_year.set '1920'

  choose('No')
  @page.opt_out_of_market_research.set(true)
  @page.accept_terms_and_conditions.set(true)

  @page.submit.click
end

Then(/^they are told that they are ineligible$/) do
  @page = Pages::IneligibleForAppointment.new
  expect(@page).to be_displayed
end

Given(/^they are below the minimum age$/) do
  choose_date_and_time

  @page.first_name.set 'First'
  @page.last_name.set 'Last'
  @page.email.set 'something@something.org'
  @page.phone.set '923902302'
  @page.memorable_word.set 'words'
  @page.date_of_birth_day.set '23'
  @page.date_of_birth_month.set '10'
  @page.date_of_birth_year.set '2013'

  choose('Yes')
  @page.opt_out_of_market_research.set(true)
  @page.accept_terms_and_conditions.set(true)

  @page.submit.click
end

Given(/^they are eligible for an appointment$/) do
  stub_appointments_api_to_succeed

  choose_date_and_time

  @page.first_name.set 'First'
  @page.last_name.set 'Last'
  @page.email.set 'something@something.org'
  @page.phone.set '923902302'
  @page.memorable_word.set 'words'
  @page.date_of_birth_day.set '23'
  @page.date_of_birth_month.set '10'
  @page.date_of_birth_year.set '1920'

  choose('Yes')
  @page.opt_out_of_market_research.set(true)
  @page.accept_terms_and_conditions.set(true)

  @page.submit.click
end

Then(/^their appointment is created$/) do
  expect(@created_telephone_appointment.start_at).to eq DateTime.new(2017, 1, 17).in_time_zone.change(hour: 12, min: 20)
  expect(@created_telephone_appointment.first_name).to eq 'First'
  expect(@created_telephone_appointment.last_name).to eq 'Last'
  expect(@created_telephone_appointment.email).to eq 'something@something.org'
  expect(@created_telephone_appointment.phone).to eq '923902302'
  expect(@created_telephone_appointment.memorable_word).to eq 'words'
  expect(@created_telephone_appointment.date_of_birth).to eq DateTime.new(1920, 10, 23).in_time_zone
  expect(@created_telephone_appointment.opt_out_of_market_research).to eq true
  expect(@created_telephone_appointment.accept_terms_and_conditions).to eq true
end

Then(/^they see a confirmation of their appointment$/) do
  @page = Pages::TelephoneAppointmentConfirmation.new
  expect(@page.booking_reference).to have_text 'test-id'
  expect(@page.start).to have_text '17 January 2017 at 12:20pm'
end

When(/^the slot becomes unavailable while they are filling in their details$/) do
  stub_appointments_api_to_fail

  choose_date_and_time

  @page.first_name.set 'First'
  @page.last_name.set 'Last'
  @page.email.set 'something@something.org'
  @page.phone.set '923902302'
  @page.memorable_word.set 'words'
  @page.date_of_birth_day.set '23'
  @page.date_of_birth_month.set '10'
  @page.date_of_birth_year.set '1920'

  choose('Yes')
  @page.opt_out_of_market_research.set(true)
  @page.accept_terms_and_conditions.set(true)

  @page.submit.click
end

When(/^they choose another time slot$/) do
  stub_appointments_api_to_succeed

  choose_date_and_time

  @page.submit.click
end