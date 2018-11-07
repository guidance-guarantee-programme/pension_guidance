RSpec.describe BookingRequests::Slot do
  describe '#realtime?' do
    it 'evaluates correctly depending on width of slot' do
      expect(described_class.new(start: '0900', end: '1000')).to be_realtime
      expect(described_class.new(start: '0900', end: '1300')).to be_windowed
    end
  end

  describe '#period' do
    context 'when realtime' do
      it 'returns the actual slot start time' do
        expect(described_class.new(start: '0900', end: '1000').period).to eq('9:00am')
      end
    end

    context 'when windowed' do
      it 'returns morning/afternoon' do
        expect(described_class.new(start: '0900', end: '1300').period).to eq('Morning')
      end
    end
  end
end
