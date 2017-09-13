require_relative '../../features/pages/tesco_booking'
require_relative '../../features/pages/tesco_booking_confirmation'

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
RSpec.feature 'Tesco Bookings' do
  scenario 'Placing a successful booking', js: true do
    Timecop.travel('2017-09-12 13:00') do
      given_the_tesco_hq_location_is_configured
      when_the_customer_attempts_a_booking
      and_they_choose_an_available_day
      and_they_choose_an_available_time
      and_they_fill_in_their_personal_details
      then_the_booking_is_placed
      and_they_see_the_confirmation
    end
  end

  def given_the_tesco_hq_location_is_configured
    Tesco.api = Class.new do
      def location(*)
        JSON.parse(IO.read('spec/fixtures/tesco_hq.json'))
      end

      def create(booking)
        booking.id = 123_456
      end
    end.new
  end

  def when_the_customer_attempts_a_booking
    @page = Pages::TescoBooking.new
    @page.load(locale: 'en', location_id: 1)
  end

  def and_they_choose_an_available_day
    @page.choose_date('2017-09-13')
  end

  def and_they_choose_an_available_time
    # times are presented in 'London' timezone
    @page.choose_time('9:10am')
    # proceed
    @page.continue.click
  end

  def and_they_fill_in_their_personal_details
    @page.first_name.set('Rick')
    @page.last_name.set('Sanchez')
    @page.email.set('rick@example.com')
    @page.phone.set('07715 930 455')
    @page.date_of_birth_day.set('01')
    @page.date_of_birth_month.set('01')
    @page.date_of_birth_year.set('1950')
    @page.memorable_word.set('snootboop')

    @page.opt_out_of_market_research.set(true)
    @page.accept_terms_and_conditions.set(true)
    @page.dc_pot_confirmed.set(true)

    @page.submit.click
  end

  def then_the_booking_is_placed
    @page = Pages::TescoBookingConfirmation.new
    expect(@page).to be_displayed
  end

  def and_they_see_the_confirmation
    expect(@page.booking_reference).to have_text('123456')
    expect(@page.start).to have_text('13 September 2017')
    expect(@page.start).to have_text('9:10am')
    expect(@page).to have_location
  end
end
