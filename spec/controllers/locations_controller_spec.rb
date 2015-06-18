RSpec.describe LocationsController, 'GET index', type: :controller do
  before do
    allow(Locations).to receive(:nearest_to_postcode).and_return([])
  end

  specify 'without a postcode param' do
    get :index

    expect(response).to redirect_to(appointments_path)
  end

  specify 'with an empty postcode' do
    get :index, postcode: ' '

    expect(response).to redirect_to(appointments_path)
  end

  specify 'with a postcode' do
    get :index, postcode: 'BT7 3AP'

    expect(response).to be_ok
  end
end
