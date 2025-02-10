require_relative '../../features/pages/nudge_referral'
require_relative '../../features/pages/new_telephone_appointment'
require_relative '../../features/pages/telephone_appointment_confirmation'

RSpec.feature 'Customer nudged appointments', js: true, vcr: true do
  scenario 'Placing a successful nudge booking' do
    Timecop.travel '2022-05-05 09:00' do
      when_a_customer_places_a_nudge_booking
      then_the_booking_is_placed
    end
  end

  def when_a_customer_places_a_nudge_booking # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @page = Pages::NudgeReferral.new
    @page.load

    @page = Pages::NewTelephoneAppointment.new
    expect(@page).to be_displayed

    @page.choose_date('2022-05-09')
    @page.choose_time('9:00am')
    @page.continue.click

    @page.first_name.set('Rick')
    @page.last_name.set('Sanchez')
    @page.phone.set('07715 930 455')
    @page.email.set('rick@example.com')

    @page.date_of_birth_day.set('01')
    @page.date_of_birth_month.set('01')
    @page.date_of_birth_year.set('1970')
    @page.memorable_word.set('snootboop')
    @page.accessibility_requirements_no.set(true)
    @page.where_you_heard.select('A Pension Provider')
    @page.dc_pot_confirmed_yes.set('true')
    @page.gdpr_consent_yes.set('true')

    @page.submit.click
  end

  def then_the_booking_is_placed
    @page = Pages::TelephoneAppointmentConfirmation.new
    expect(@page.booking_reference).to be_present
  end
end
