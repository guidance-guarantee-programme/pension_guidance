RSpec.describe Tesco::Api do
  describe '#locations', vcr: true do
    subject { described_class.new.locations }

    it 'returns deserialized locations' do
      expect(subject).to be_present
      expect(subject.first.values).to include(
        'Tesco 1',
        '1 Some Street',
        'Some Place',
        'Some Town',
        'Some County'
      )
    end
  end
end
