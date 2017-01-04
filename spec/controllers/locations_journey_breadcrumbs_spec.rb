RSpec.describe 'locations journey breadcrumbs', type: :controller do
  let(:book_an_appointment) { Breadcrumb.book_an_appointment.title }
  let(:how_to_book) { Breadcrumb.how_to_book_face_to_face.title }

  subject(:breadcrumbs) { assigns(:breadcrumbs).map(&:title) }

  describe GuidesController do
    let(:guide) { '' }

    before do
      get :show, params: { id: guide }
    end

    context 'book a free appointment' do
      let(:guide) { 'appointments' }

      it { is_expected.to be_empty }
    end

    context 'how to book' do
      let(:guide) { 'book-face-to-face' }

      it { is_expected.to eq([book_an_appointment]) }
    end
  end

  describe LocationsController do
    let(:location_id) { 'cab-bureau' }
    let(:location) { double(booking_location_id: '') }

    before do
      allow(Locations).to receive(:find).with(location_id).and_return(location)
    end

    context 'find a face-to-face appointment location' do
      before do
        get :index
      end

      it { is_expected.to eq([book_an_appointment, how_to_book]) }
    end

    context 'appointment location details' do
      before do
        get :show, params: { id: location_id }
      end

      it { is_expected.to eq([book_an_appointment, how_to_book]) }
    end
  end
end
