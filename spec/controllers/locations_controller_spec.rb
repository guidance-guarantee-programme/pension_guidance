RSpec.describe LocationsController, type: :controller do
  describe 'POST search' do
    before do
      allow(Locations).to receive(:nearest_to_postcode).and_return([double, double])
    end

    specify 'with an empty postcode' do
      post :search, params: { locale: :en, postcode: '' }

      expect(response).to render_template(:empty_postcode)
    end

    specify 'with an invalid postcode' do
      allow(Locations).to receive(:nearest_to_postcode).and_raise(Geocoder::InvalidPostcode)

      post :search, params: { locale: :en, postcode: 'LONDON' }

      expect(response).to render_template(:invalid_postcode)
    end

    specify 'with a failed postcode lookup' do
      allow(Locations).to receive(:nearest_to_postcode).and_raise(Geocoder::FailedLookup)

      post :search, params: { locale: :en, postcode: 'BT7 3AP' }

      expect(response).to render_template(:failed_lookup)
    end

    specify 'with a postcode' do
      post :search, params: { locale: :en, postcode: 'BT7 3AP' }

      expect(response).to render_template(:search)
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
      expect { get :show, params: { locale: :en, id: invalid_id } }.to raise_error(ActionController::RoutingError)
    end

    specify 'with a valid id' do
      get :show, params: { locale: :en, id: valid_id }

      expect(response).to be_ok
    end
  end
end
