RSpec.describe Locations::Location do
  subject { described_class.new(id: 1) }

  before do
    allow(BookingRequests).to receive(:slots) { [1] }
  end

  context 'when online booking is disabled' do
    it 'does not report limited availability' do
      subject.online_booking_enabled = false

      expect(subject).to_not be_limited_availability
    end
  end

  context 'when online booking is enabled' do
    it 'reports limited availability' do
      subject.online_booking_enabled = true

      expect(subject).to be_limited_availability
    end
  end

  describe '#realtime_slots?' do
    context 'when the location is realtime enabled' do
      before { subject.realtime = true }

      it 'is true when realtime slots exist' do
        allow(BookingRequests).to receive(:slots) do
          [instance_double(BookingRequests::Slot, realtime?: true)]
        end

        expect(subject).to be_realtime_slots
      end

      it 'is false otherwise' do
        allow(BookingRequests).to receive(:slots) do
          [instance_double(BookingRequests::Slot, realtime?: false)]
        end

        expect(subject).not_to be_realtime_slots
      end
    end

    context 'when the location is not realtime enabled' do
      it 'is false' do
        expect(subject).not_to be_realtime_slots
      end
    end
  end
end
