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

    expect(@page).to have_no_alternative_journeys

    @page.choose_date('2021-09-20')
    @page.choose_time('10:00am')
    @page.continue.click

    expect(@page).to have_no_need_help_banner
    expect(@page).to have_no_date_of_birth_hint
    expect(@page).to have_no_data_sharing_banner
    # hide and default these fields
    expect(@page.hidden_dc_pot_confirmed.value).to eq('not-sure')
    expect(@page.hidden_gdpr_consent.value).to eq('no')
    expect(@page.hidden_where_you_heard.value).to eq('2') # pension provider

    @page.first_name.set('Rick')
    @page.last_name.set('Sanchez')
    @page.email.set('rick@example.com')
    @page.phone.set('07715 930 455')
    @page.date_of_birth_day.set('01')
    @page.date_of_birth_month.set('01')
    @page.date_of_birth_year.set('1950')
    @page.memorable_word.set('snootboop')
    @page.referrer.set('Big Pensions Co.')

    @page.submit.click
  end

  def then_the_booking_is_placed
    @page = Pages::TelephoneAppointmentConfirmation.new

    expect(@page.booking_reference).to have_text('8')
    expect(@page).to have_text('0800 015 4906')
  end
end
