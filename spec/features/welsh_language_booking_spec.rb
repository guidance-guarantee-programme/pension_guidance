require_relative '../../features/pages/welsh_language_booking_request'
require_relative '../../features/pages/welsh_language_booking_completed'

RSpec.feature 'Welsh language bookings' do
  scenario 'Customer attempts to place an invalid booking request', js: true, vcr: true do
    when_the_customer_views_the_welsh_language_booking_form
    when_they_submit_their_booking_request
    then_they_are_told_there_are_errors
  end

  scenario 'Customer places a face-to-face booking request successfully', js: true, vcr: true do
    skip 'temporarily disabled face-to-face bookings due to COVID-19'

    when_the_customer_views_the_welsh_language_booking_form
    and_chooses_a_face_to_face_booking
    and_selects_their_preferred_location
    and_provides_their_details
    when_they_submit_their_booking_request
    then_the_booking_is_created
  end

  scenario 'Customer places a telephone booking request successfully', js: true, vcr: true do
    when_the_customer_views_the_welsh_language_booking_form
    and_provides_their_details
    when_they_submit_their_booking_request
    then_the_booking_is_created
  end

  def when_the_customer_views_the_welsh_language_booking_form
    @page = Pages::WelshLanguageBookingRequest.new
    @page.load

    expect(@page).to be_displayed
  end

  def and_chooses_a_telephone_booking
    @page.phone_booking.set(true)
  end

  def and_chooses_a_face_to_face_booking
    @page.face_to_face_booking.set(true)
  end

  def and_selects_their_preferred_location
    @page.wait_until_location_visible

    @page.location.select('Ammanford Library')
  end

  def and_provides_their_details # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @page.first_name.set('Ben')
    @page.last_name.set('Smith')
    @page.email.set('ben@example.com')
    @page.phone.set('07715 930 455')
    @page.memorable_word.set('spoon')
    @page.day_of_birth.set('01')
    @page.month_of_birth.set('01')
    @page.year_of_birth.set('1960')
    @page.defined_contribution_pot_confirmed_yes.set(true)
    @page.accessibility_needs_yes.set(true)
    @page.wait_until_adjustments_visible
    @page.adjustments.set('These adjustments')
    @page.additional_info.set('Before 1PM.')
    @page.where_you_heard.select('Cyflogwr')
    @page.gdpr_consent_yes.set(true)
  end

  def when_they_submit_their_booking_request
    @page.submit.click
  end

  def then_the_booking_is_created
    @page = Pages::WelshLanguageBookingCompleted.new
    expect(@page).to be_displayed
  end

  def then_they_are_told_there_are_errors
    expect(@page).to have_errors
  end
end
