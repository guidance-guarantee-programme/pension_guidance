require_relative '../../features/pages/bsl_booking_request'
require_relative '../../features/pages/bsl_booking_completed'

RSpec.feature 'British Sign Language bookings' do
  scenario 'Customer attempts to place a BSL booking request', js: true, vcr: true do
    when_the_customer_views_the_bsl_booking_form
    and_they_submit_their_booking_request
    then_they_are_told_there_are_errors
  end

  scenario 'Customer places a BSL booking request successfully', js: true, vcr: true do
    when_the_customer_views_the_bsl_booking_form
    and_provides_their_details
    and_they_submit_their_booking_request
    then_the_booking_is_created
  end

  def when_the_customer_views_the_bsl_booking_form
    @page = Pages::BslBookingRequest.new
    @page.load

    expect(@page).to be_displayed
  end

  def and_provides_their_details # rubocop:disable AbcSize, MethodLength
    @page.first_name.set('Ben')
    @page.last_name.set('Smith')
    @page.email.set('ben@example.com')
    @page.phone.set('07715 930 455')
    @page.memorable_word.set('spoon')
    @page.day_of_birth.set('01')
    @page.month_of_birth.set('01')
    @page.year_of_birth.set('1960')
    @page.defined_contribution_pot_confirmed_yes.set(true)
    @page.accessibility_needs.set(true)
    @page.additional_info.set('Before 1PM.')
    @page.where_you_heard.select('TV advert')
    @page.gdpr_consent_yes.set(true)
  end

  def and_they_submit_their_booking_request
    @page.submit.click
  end

  def then_the_booking_is_created
    @page = Pages::BslBookingCompleted.new
    expect(@page).to be_displayed
  end

  def then_they_are_told_there_are_errors
    expect(@page).to have_errors
  end
end
