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

  describe '#location', vcr: true do
    subject { described_class.new.location(1) }

    it 'returns deserialized slots' do
      expect(subject).to be_present
      expect(subject['windowed_slots'].keys).to match_array(
        %w(2017-09-12 2017-09-13 2017-09-14 2017-09-15)
      )
    end
  end
end
