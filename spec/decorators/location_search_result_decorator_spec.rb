RSpec.describe LocationSearchResultDecorator do
  let(:address) { "Street\nTown\nPostcode" }
  let(:distance) { 1.0489736864844752 }
  let(:search_result) { double(address: address, distance: distance) }

  subject(:decorator) { described_class.new(search_result) }

  specify { expect(decorator.address).to eq('Street, Town, Postcode') }
  specify { expect(decorator.distance).to eq('1.05') }
end
