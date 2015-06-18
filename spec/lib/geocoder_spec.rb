RSpec.describe Geocoder, '.lookup' do
  let(:postcode) { 'postcode' }
  let(:postcodes_io) { double }
  let(:lat) { 1 }
  let(:lng) { 0 }
  let(:lat_lng) { [lat, lng] }
  let(:lookup) { nil }

  subject { described_class.lookup(postcode) }

  before do
    allow(Postcodes::IO).to receive(:new).and_return(postcodes_io)
    allow(postcodes_io).to receive(:lookup).with(postcode).and_return(lookup)
  end

  context 'with an invalid postode' do
    it { is_expected.to be_nil }
  end

  context 'with a valid postode' do
    let(:lookup) { double(latitude: lat, longitude: lng) }

    it { is_expected.to eq(lat_lng) }
  end
end
