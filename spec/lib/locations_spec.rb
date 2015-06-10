RSpec.describe Locations do
  describe '.nearest_to_postcode' do
    let(:postcode) { 'SW1A 2HQ' }
    let(:limit) { 5 }

    it 'geocodes the postcode' do
      expect(Geocoder).to receive(:coordinates).with(postcode)
      described_class.nearest_to_postcode(postcode, limit: limit)
    end
  end
end
