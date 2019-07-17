RSpec.describe Locations::Location do
  subject { described_class.new(id: 1) }

  before do
    allow(BookingRequests).to receive(:slots) { Hash['2019-06-06': ['2019-06-06 13:00:00 UTC']] }
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
end
