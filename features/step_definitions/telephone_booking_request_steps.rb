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
    telephone_appointment.id = 123_456
  end
end

def stub_appointments_api_to_fail
  allow(@appointment_api_fake).to receive(:create).once.and_return(false)
end

Given('the customer makes a Lloyds signposting referral') do
  @page = Pages::NewTelephoneAppointment.new
  @page.load(locale: :en, query: { lbgptl: true })
end

Then('they are show the Lloyds signposting banner') do
  expect(@page).to be_displayed
end

Given(/^the agent makes a smarter signposting referral$/) do
  @page = Pages::SmarterSignpostingReferral.new
  @page.load
end

Given(/^the customer wants to book a phone appointment$/) do
  @page = Pages::NewTelephoneAppointment.new
  @page.load(locale: :en)
  expect(@page).to be_displayed
end

Then('they are redirected to the telephone booking') do
  @page = Pages::NewTelephoneAppointment.new
  expect(@page).to be_displayed
end

Then('they are shown the signposting banner') do
  expect(@page).to have_smarter_signposting_banner
end

When('they cancel the referral') do
  @page.cancel_smarter_signposting.click
end

Then('they are not shown the signposting banner') do
  expect(@page).to have_no_smarter_signposting_banner
end

When(/^they choose a date after the slots on that day have been taken$/) do
  @page.find('button[value="2017-01-21"]').click
end

Then(/^they are told to choose another day$/) do
  expect(@page).to have_choose_other_time_message
end

def choose_date_and_time
  @page.find('button[value="2017-01-17"]').click
  @page.find('label', text: '12:20pm').click
  @page.continue.click
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
  @page.dc_pot_confirmed_no.set(true)
  @page.where_you_heard.select('Other')
  @page.gdpr_consent_yes.set(true)
  @page.accessibility_requirements_yes.set(true)
  @page.adjustments.set('Some required adjustments')
  @page.additional_info.set('Bleh bleh')

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
  @page.dc_pot_confirmed_yes.set(true)
  @page.where_you_heard.select('Other')
  @page.gdpr_consent_yes.set(true)
  @page.accessibility_requirements_yes.set(true)
  @page.adjustments.set('Blah blah')
  @page.additional_info.set('Bleh bleh')

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
  @page.dc_pot_confirmed_yes.set(true)
  @page.gdpr_consent_yes.set(true)
  @page.where_you_heard.select('Other')
  @page.accessibility_requirements_yes.set(true)
  @page.adjustments.set('Some required adjustments')
  @page.additional_info.set('Bleh bleh')
  @page.attended_digital_yes.set(true)

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
  expect(@created_telephone_appointment.gdpr_consent).to eq 'yes'
  expect(@created_telephone_appointment.where_you_heard).to eq '17'
  expect(@created_telephone_appointment.accessibility_requirements).to eq 'true'
  expect(@created_telephone_appointment.adjustments).to eq 'Some required adjustments'
end

Then(/^they see a confirmation of their appointment$/) do
  @page = Pages::TelephoneAppointmentConfirmation.new
  expect(@page.booking_reference).to have_text '123456'
  expect(@page.start).to have_text '17 January 2017'
  expect(@page.start).to have_text '12:20pm'
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
  @page.dc_pot_confirmed_yes.set(true)
  @page.where_you_heard.select('Other')
  @page.gdpr_consent_yes.set(true)
  @page.accessibility_requirements_yes.set(true)
  @page.adjustments.set('Some required adjustments')
  @page.additional_info.set('Bleh')

  @page.submit.click
end

When(/^they choose another time slot$/) do
  stub_appointments_api_to_succeed

  choose_date_and_time

  @page.submit.click
end
