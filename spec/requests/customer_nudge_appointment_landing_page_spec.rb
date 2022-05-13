require 'spec_helper'

RSpec.describe 'Landing page for customer nudge bookings', type: :request do
  context 'When a customer lands in the regular journey' do
    specify 'Visiting the landing page sets the nudge' do
      when_the_customer_visits_the_landing_page
      then_they_are_redirected_to_the_phone_booking_journey
    end
  end

  context 'When a customer lands in the embedded provider journey' do
    specify 'Visiting the landing page sets the nudge/embedded and displays the landing page' do
      when_the_customer_visits_the_landing_page_with_the_embed_parameter
      then_they_are_redirected_to_the_phone_booking_nudge_landing_page
    end
  end

  def then_they_are_redirected_to_the_phone_booking_nudge_landing_page
    expect(response).to redirect_to('/en/telephone-appointments/nudge')
  end

  def when_the_customer_visits_the_landing_page_with_the_embed_parameter
    get '/en/nudge/new?embedded=true'
  end

  def when_the_customer_visits_the_landing_page
    get '/en/nudge/new'
  end

  def then_they_are_redirected_to_the_phone_booking_journey
    expect(response).to redirect_to('/en/telephone-appointments/new?nudged=true')
  end
end
