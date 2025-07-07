require_relative '../../features/pages/telephone_appointment_confirmation'
require_relative '../../features/pages/telephone_appointment_rescheduling'
require_relative '../../features/pages/telephone_appointment_rescheduling_ineligible'
require_relative '../../features/pages/telephone_appointment_rescheduling_failure'

# rubocop:disable Metrics/AbcSize
RSpec.feature 'Telephone appointment rescheduling' do
  scenario 'Seeing validation errors when nothing is provided', vcr: true do
    when_the_customer_visits_the_rescheduling_page
    and_submits_without_completing_the_fields
    then_they_see_validation_errors
  end

  scenario 'Successfully rescheduling the appointment', js: true, vcr: true do
    when_the_customer_visits_the_rescheduling_page
    and_completes_the_necessary_fields
    and_selects_a_new_date_and_time
    and_agrees_to_reschedule_their_appointment
    then_they_see_the_confirmation
  end

  scenario 'Appointment could not be matched, ineligible result', vcr: true do
    when_the_customer_visits_the_rescheduling_page
    and_completes_the_fields_with_unmatchable_entries
    then_they_are_shown_the_ineligible_result
  end

  scenario 'Rescheduling fails due to slot being taken', js: true do
    stub_rescheduling_api_to_fail do
      when_the_customer_visits_the_rescheduling_page
      and_completes_the_necessary_fields
      and_selects_a_new_date_and_time
      and_agrees_to_reschedule_their_appointment
      then_they_see_the_failure_result
    end
  end

  def stub_rescheduling_api_to_fail
    @appointment_api_fake = double(:telephone_appointment_api)

    allow(TelephoneAppointmentsApi).to receive(:new).and_return(@appointment_api_fake)

    allow(@appointment_api_fake).to receive(:find).and_return({ 'start' => '2025-07-07 15:50' }.as_json)

    allow(@appointment_api_fake).to receive(:slots).and_return(
      JSON.parse(File.read('features/fixtures/rescheduling_bookable_slots.json'))
    )

    allow(@appointment_api_fake).to receive(:reschedule).and_return(false)

    yield
  end

  def then_they_see_the_failure_result
    @page = Pages::TelephoneAppointmentReschedulingFailure.new
    expect(@page).to be_displayed
    expect(@page).to have_failure_notice
  end

  def and_completes_the_fields_with_unmatchable_entries
    @page.booking_reference.set(999)
    @page.date_of_birth_day.set(1)
    @page.date_of_birth_month.set(1)
    @page.date_of_birth_year.set(1980)
    @page.reason.select('Illness')
    @page.submit.click
  end

  def then_they_are_shown_the_ineligible_result
    @page = Pages::TelephoneAppointmentReschedulingIneligible.new
    expect(@page).to be_displayed
  end

  def and_completes_the_necessary_fields
    @page.booking_reference.set(5)
    @page.date_of_birth_day.set(1)
    @page.date_of_birth_month.set(1)
    @page.date_of_birth_year.set(1980)
    @page.reason.select('Illness')
    @page.submit.click
  end

  def and_selects_a_new_date_and_time
    expect(@page.current_appointment.booking_reference).to have_text('5')
    expect(@page.current_appointment.date).to have_text('7 July 2025')
    expect(@page.current_appointment.time).to have_text('3:50pm (BST)')

    @page.choose_date('2025-07-07')
    @page.choose_time('9:10am')
    @page.continue.click
  end

  def and_agrees_to_reschedule_their_appointment
    expect(@page.new_appointment.booking_reference).to have_text('5')
    expect(@page.new_appointment.date).to have_text('7 July 2025')
    expect(@page.new_appointment.time).to have_text('9:10am (BST)')

    @page.new_appointment.submit.click
  end

  def then_they_see_the_confirmation
    @page = Pages::TelephoneAppointmentConfirmation.new
    expect(@page.booking_reference).to have_text('5')
    expect(@page.start).to have_text('7 July 2025')
    expect(@page.start).to have_text('9:10am')
  end

  def when_the_customer_visits_the_rescheduling_page
    @page = Pages::TelephoneAppointmentRescheduling.new
    @page.load

    expect(@page).to be_displayed
  end

  def and_submits_without_completing_the_fields
    @page.submit.click
  end

  def then_they_see_validation_errors
    expect(@page).to have_errors
  end
end
# rubocop:enable Metrics/AbcSize
