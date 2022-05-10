require 'spec_helper'

RSpec.describe 'Landing page for customer nudge bookings', type: :request do
  context 'When a customer lands in the regular journey' do
    specify 'Visiting the landing page sets the nudge cookie' do
      when_the_customer_visits_the_landing_page
      then_the_nudge_cookie_is_set
      and_they_are_redirected_to_the_phone_booking_journey
    end

    specify 'Unsetting the nudge cookie upon confirmation' do
      when_the_nudge_cookie_is_set
      and_the_customer_completes_a_booking
      then_the_nudge_cookie_is_cleared
    end
  end

  def when_the_customer_visits_the_landing_page
    get '/en/nudge/new'
  end

  def then_the_nudge_cookie_is_set
    expect(response.cookies['nudged']).to eq('true')
  end

  def and_they_are_redirected_to_the_phone_booking_journey
    expect(response).to redirect_to('/en/telephone-appointments/new')
  end

  def when_the_nudge_cookie_is_set
    cookies['nudged'] = 'true'
  end

  def and_the_customer_completes_a_booking
    get '/en/telephone-appointments/confirmation?booking_reference=123456&booking_date=2022-05-05'
  end

  def then_the_nudge_cookie_is_cleared
    expect(cookies['nudged']).to be_blank
  end
end
