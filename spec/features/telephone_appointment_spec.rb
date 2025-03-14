require_relative '../../features/pages/new_telephone_appointment'

RSpec.feature 'Customer books a telephone appointment', type: :feature do
  scenario 'When creating a booking from a cancellation referral' do
    with_telephone_availability
    when_the_customer_creates_a_booking_from_a_cancellation
    then_the_booking_is_marked_as_referred
  end

  scenario 'Viewing the widget frame' do
    with_telephone_availability
    when_the_widget_is_embedded
    then_the_pension_wise_branding_is_omitted
    and_the_skip_link_is_omitted
    and_the_cookie_banner_is_omitted
    and_the_frame_options_are_permissive
  end

  def when_the_customer_creates_a_booking_from_a_cancellation
    @page = Pages::NewTelephoneAppointment.new
    @page.load(
      locale: :en,
      query: { rebooked_from: 'BAhJIgsxODE0MzcGOgZFVA==--d930183cb0cb3acb4ff49984f7d2aff9551cf4fa' }
    )
  end

  def then_the_booking_is_marked_as_referred
    expect(@page.response_headers['Set-Cookie']).to eq('rebooked_from_id=181437; path=/')
  end

  def when_the_widget_is_embedded
    @page = Pages::NewTelephoneAppointment.new
    @page.load(locale: :en)
  end

  def then_the_pension_wise_branding_is_omitted
    expect(@page).to have_no_branding
  end

  def and_the_skip_link_is_omitted
    expect(@page).to have_no_skiplink
  end

  def and_the_cookie_banner_is_omitted
    expect(@page).to have_no_cookie_banner
  end

  def and_the_frame_options_are_permissive
    expect(@page.response_headers['X-Frame-Options']).to be_nil
  end

  def with_telephone_availability
    @appointment_api_fake = double(:telephone_appointment_api)
    @appointment_api_data = JSON.parse(
      IO.read(Rails.root.join('features/fixtures/bookable_slots.json'))
    )

    allow(TelephoneAppointmentsApi).to receive(:new).and_return(@appointment_api_fake)
    allow(@appointment_api_fake).to receive(:slots).and_return(@appointment_api_data)
  end

  scenario 'Refreshing their confirmation' do
    # visit without required params
    visit confirmation_telephone_appointments_path(locale: :en)

    expect(page.current_path).to eq(root_path(locale: :en))
  end
end
