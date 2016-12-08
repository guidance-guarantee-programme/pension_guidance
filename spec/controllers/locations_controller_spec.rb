RSpec.describe LocationsController, type: :controller do
  describe 'GET index' do
    before do
      allow(Locations).to receive(:nearest_to_postcode).and_return([double, double])
    end

    specify 'without a postcode param' do
      get :index

      expect(response).to render_template(:search)
    end

    specify 'with an empty postcode' do
      get :index, params: { postcode: ' ' }

      expect(response).to render_template(:search)
    end

    specify 'with an invalid postcode' do
      allow(Locations).to receive(:nearest_to_postcode).and_raise(Geocoder::InvalidPostcode)

      get :index, params: { postcode: 'LONDON' }

      expect(response).to render_template(:invalid_postcode)
    end

    specify 'with a failed postcode lookup' do
      allow(Locations).to receive(:nearest_to_postcode).and_raise(Geocoder::FailedLookup)

      get :index, params: { postcode: 'BT7 3AP' }

      expect(response).to render_template(:failed_lookup)
    end

    specify 'with a postcode' do
      get :index, params: { postcode: 'BT7 3AP' }

      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    let(:valid_id) { 'cab-bureau' }
    let(:invalid_id) { 'invalid' }
    let(:location) { double(booking_location_id: '') }

    before do
      allow(Locations).to receive(:find).with(invalid_id)
      allow(Locations).to receive(:find).with(valid_id).and_return(location)
    end

    specify 'with an invalid id' do
      expect { get :show, params: { id: invalid_id } }.to raise_error(ActionController::RoutingError)
    end

    specify 'with a valid id' do
      get :show, params: { id: valid_id }

      expect(response).to be_ok
    end
  end
end
