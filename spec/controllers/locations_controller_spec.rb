RSpec.describe LocationsController, type: :controller do
  describe 'GET index' do
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

  describe 'GET show' do
    let(:valid_id) { 'cab-bureau' }
    let(:invalid_id) { 'invalid' }
    let(:location) { double }

    before do
      allow(Locations).to receive(:find).with(invalid_id)
      allow(Locations).to receive(:find).with(valid_id).and_return(location)
    end

    specify 'with an invalid id' do
      expect { get :show, id: invalid_id }.to raise_error(ActionController::RoutingError)
    end

    specify 'with a valid id' do
      get :show, id: valid_id

      expect(response).to be_ok
    end
  end
end
