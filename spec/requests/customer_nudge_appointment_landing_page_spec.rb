require 'spec_helper'

RSpec.describe 'Landing page for customer nudge bookings', type: :request do
  specify 'Visiting the landing page sets the nudge cookie' do
    get '/en/nudge/new'

    expect(response.cookies['nudged']).to eq('true')
    expect(response).to redirect_to('/en/telephone-appointments/new')
  end

  specify 'Unsetting the nudge cookie upon confirmation' do
    cookies['nudged'] = 'true'

    get '/en/telephone-appointments/confirmation?booking_reference=123456&booking_date=2022-05-05'

    expect(cookies['nudged']).to be_blank
  end
end
