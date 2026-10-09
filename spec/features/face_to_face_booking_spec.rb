require_relative '../../features/pages/face_to_face_booking_request'
require_relative '../../features/pages/face_to_face_booking_completed'

RSpec.feature 'Face-to-face walk-in bookings' do
  scenario 'Customer attempts to place a booking', js: true, vcr: true do
    when_the_customer_views_the_booking_form
    and_they_submit_their_booking
    then_they_are_told_there_are_errors
  end

  scenario 'Customer places a booking successfully', js: true, vcr: true do
    when_the_customer_views_the_booking_form
    and_provides_their_details
    and_they_submit_their_booking
    then_the_booking_is_created
  end

  def when_the_customer_views_the_booking_form
    @page = Pages::FaceToFaceBookingRequest.new
    @page.load

    expect(@page).to be_displayed
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
    @page.postcode.set('RG1 1AL')
    @page.referrer.set('Pension Co')
    @page.accessibility_requirements_yes.set(true)
    @page.wait_until_adjustments_visible
    @page.adjustments.set('Adjustments')
    @page.additional_info.set('Before 1PM.')
    @page.where_you_heard.select('TV advert')
    @page.gdpr_consent_yes.set(true)

    expect(@page).to have_no_support_name
    @page.supported_yes.set(true)
    @page.wait_until_support_name_visible
    @page.support_name.set('Dave David')
    @page.support_relationship.set('Carer')
    @page.support_email.set('dave@example.com')
    @page.support_phone.set('07715 930 455')
  end

  def and_they_submit_their_booking
    @page.submit.click
  end

  def then_the_booking_is_created
    @page = Pages::FaceToFaceBookingCompleted.new
    expect(@page).to be_displayed
  end

  def then_they_are_told_there_are_errors
    expect(@page).to have_errors
  end
end
