RSpec.describe LocationSearchResultDecorator do
  let(:address) { "Street\nTown\nPostcode" }
  let(:distance) { 1.0489736864844752 }
  let(:search_result) { double(address: address, distance: distance) }

  subject(:decorator) { described_class.new(search_result) }

  specify { expect(decorator.address_encoded).to eq('Street%2C%20Town%2C%20Postcode') }
  specify { expect(decorator.distance).to eq('1.05') }

  context 'when address contains special characters' do
    let(:address) { "Road & Street\nTown\nPostcode" }
    specify { expect(decorator.address_encoded).to eq('Road%20%26%20Street%2C%20Town%2C%20Postcode') }
  end
end
