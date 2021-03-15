RSpec.describe 'Error pages', type: :request do
  specify 'employer location not found', vcr: true do
    get '/en/employers/2/locations/1'

    expect(response).to be_not_found
    expect(response).to render_template(:not_found)
  end

  specify 'location not found' do
    get '/en/locations/c63c56e9-2111-43cc-bb72-c58ad4053bfc/booking-request/step-one'

    # this gets handled as 404
    expect(response).to_not be_ok
  end

  specify 'category not found' do
    get '/en/browse/non-existent-category'

    expect(response).to be_not_found
    expect(response).to render_template(:not_found)
  end

  specify 'guide not found' do
    get '/en/non-existent-guide'

    expect(response).to be_not_found
    expect(response).to render_template(:not_found)
  end

  specify 'English alternative for Welsh bookings' do
    get '/en/booking-requests'

    expect(response).to be_not_found
  end
end
