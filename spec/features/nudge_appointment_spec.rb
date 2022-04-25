require_relative '../../features/pages/new_nudge_appointment'
require_relative '../../features/pages/nudge_appointment_confirmation'

RSpec.feature 'Placing a nudge booking' do
  scenario 'Placing a successful booking with an email contact', js: true, vcr: true do
    Timecop.travel '2022-04-26 09:00' do
      when_a_customer_places_a_nudge_booking
      then_the_booking_is_placed
    end
  end

  def when_a_customer_places_a_nudge_booking
    @page = Pages::NewNudgeAppointment.new
    @page.load

    @page.choose_date('2022-05-04')
    @page.choose_time('8:50am')
    @page.continue.click

    @page.first_name.set('Rick')
    @page.last_name.set('Sanchez')
    @page.phone.set('07715 930 455')

    @page.confirmation_email.set(true)
    @page.wait_until_email_visible
    @page.email.set('rick@example.com')

    @page.date_of_birth_day.set('01')
    @page.date_of_birth_month.set('01')
    @page.date_of_birth_year.set('1970')
    @page.memorable_word.set('snootboop')

    @page.submit.click
  end

  def then_the_booking_is_placed
    @page = Pages::NudgeAppointmentConfirmation.new
    expect(@page).to be_displayed

    expect(@page.booking_reference).to have_text('525898')
  end
end
