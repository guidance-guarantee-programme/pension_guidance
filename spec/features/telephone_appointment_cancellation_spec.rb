require_relative '../../features/pages/telephone_appointment_cancellation'
require_relative '../../features/pages/telephone_appointment_cancellation_success'
require_relative '../../features/pages/telephone_appointment_cancellation_failure'

RSpec.feature 'Telephone appointment cancellations' do
  scenario 'Successfully cancelling the appointment', vcr: true do
    given_the_customer_visits_the_cancellation_page
    when_they_complete_their_appointment_details
    then_they_see_the_cancellation_success_page
  end

  scenario 'Seeing validation errors when nothing is provided' do
    given_the_customer_visits_the_cancellation_page
    when_they_dont_complete_their_appointment_details
    then_they_see_the_validation_errors
  end

  scenario 'Failing to cancel the appointment', vcr: true do
    given_the_customer_visits_the_cancellation_page
    when_they_complete_their_appointment_details
    then_they_see_the_cancellation_failure_page
  end

  def then_they_see_the_cancellation_failure_page
    @page = Pages::TelephoneAppointmentCancellationFailure.new
    expect(@page).to be_displayed
  end

  def when_they_dont_complete_their_appointment_details
    expect(@page).to be_displayed

    @page.submit.click
  end

  def then_they_see_the_validation_errors
    expect(@page).to have_errors
  end

  def given_the_customer_visits_the_cancellation_page
    @page = Pages::TelephoneAppointmentCancellation.new
    @page.load
  end

  def when_they_complete_their_appointment_details
    expect(@page).to be_displayed

    @page.booking_reference.set '181437'
    @page.date_of_birth_day.set '1'
    @page.date_of_birth_month.set '1'
    @page.date_of_birth_year.set '1950'
    @page.reason.select 'Inconvenient time'
    @page.submit.click
  end

  def then_they_see_the_cancellation_success_page
    @page = Pages::TelephoneAppointmentCancellationSuccess.new
    expect(@page).to be_displayed

    # tee up the rebook from this original appointment
    expect(@page.rebook_link[:href]).to eq(
      '/en/telephone-appointments/new?rebooked_from=BAhJIgsxODE0MzcGOgZFVA==--d930183cb0cb3acb4ff49984f7d2aff9551cf4fa'
    )
  end
end
