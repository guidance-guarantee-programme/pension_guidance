require_relative '../../features/pages/new_telephone_appointment'
require_relative '../../features/pages/telephone_appointment_confirmation'

RSpec.feature 'Due diligence bookings' do
  scenario 'Placing a successful due diligence booking', js: true, vcr: true do
    Timecop.travel('2023-08-15 10:00') do
      when_a_customer_attempts_to_book_a_due_diligence_appointment
      then_the_booking_is_placed
    end
  end

  def when_a_customer_attempts_to_book_a_due_diligence_appointment # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    @page = Pages::NewTelephoneAppointment.new
    @page.load(locale: 'en', query: { schedule_type: 'due_diligence' })

    expect(@page).to have_no_alternative_journeys

    @page.choose_date('2023-08-23')
    @page.choose_time('10:10am')
    @page.continue.click

    expect(@page).to have_no_need_help_banner
    expect(@page).to have_no_date_of_birth_hint
    expect(@page).to have_no_data_sharing_banner
    # hide and default these fields
    expect(@page.hidden_dc_pot_confirmed.value).to eq('not-sure')
    expect(@page.hidden_gdpr_consent.value).to eq('no')
    expect(@page.hidden_where_you_heard.value).to eq('2') # pension provider
    # ensure links back to rebook are the correct schedule type
    expect(@page.change_date_time[:href]).to end_with('?schedule_type=due_diligence')

    @page.first_name.set('Rick')
    @page.last_name.set('Sanchez')
    @page.email.set('rick@example.com')
    @page.country_of_residence.select('France')
    @page.phone.set('07715 930 455')
    @page.date_of_birth_day.set('01')
    @page.date_of_birth_month.set('01')
    @page.date_of_birth_year.set('1980')
    @page.accessibility_requirements_no.set(true)
    @page.memorable_word.set('snootboop')
    @page.referrer.set('Big Pensions Co.')

    @page.submit.click
  end

  def then_the_booking_is_placed
    @page = Pages::TelephoneAppointmentConfirmation.new

    expect(@page.booking_reference).to have_text('5')
    expect(@page).to have_text('0800 015 4906')
    expect(@page).to have_text('10:10am (BST)')
  end
end
