require_relative '../../features/pages/new_telephone_appointment'
require_relative '../../features/pages/telephone_appointment_confirmation'

RSpec.feature 'Due diligence bookings' do
  scenario 'Placing a successful due diligence booking', js: true, vcr: true do
    Timecop.travel('2021-09-14 13:00') do
      when_a_customer_attempts_to_book_a_due_diligence_appointment
      then_the_booking_is_placed
    end
  end

  def when_a_customer_attempts_to_book_a_due_diligence_appointment # rubocop:disable MethodLength, AbcSize
    @page = Pages::NewTelephoneAppointment.new
    @page.load(locale: 'en', query: { schedule_type: 'due_diligence' })

    @page.choose_date('2021-09-20')
    @page.choose_time('10:00am')
    @page.continue.click

    @page.first_name.set('Rick')
    @page.last_name.set('Sanchez')
    @page.email.set('rick@example.com')
    @page.phone.set('07715 930 455')
    @page.date_of_birth_day.set('01')
    @page.date_of_birth_month.set('01')
    @page.date_of_birth_year.set('1950')
    @page.memorable_word.set('snootboop')
    @page.gdpr_consent_yes.set(true)
    @page.dc_pot_confirmed_yes.set(true)
    @page.where_you_heard.select('An employer')

    @page.submit.click
  end

  def then_the_booking_is_placed
    @page = Pages::TelephoneAppointmentConfirmation.new

    expect(@page.booking_reference).to have_text('8')
  end
end
