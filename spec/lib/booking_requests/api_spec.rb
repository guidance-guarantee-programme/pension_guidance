require 'securerandom'

RSpec.describe BookingRequests::Api, :vcr do
  let(:payload) do
    {
      booking_request: {
        location_id: SecureRandom.uuid,
        name: 'Lucius Needful',
        email: 'lucius@example.com',
        phone: '0208 244 3987',
        memorable_word: 'meseeks',
        age_range: '55-plus',
        accessibility_requirements: false,
        defined_contribution_pot: true,
        slots: [
          { priority: 1, date: '2016-01-01', from: '0900', to: '1300' },
          { priority: 2, date: '2016-01-01', from: '1300', to: '1700' },
          { priority: 3, date: '2016-01-02', from: '0900', to: '1300' }
        ]
      }
    }
  end

  subject { described_class.new }

  describe '#create' do
    context 'when the request is successful' do
      it 'returns true' do
        expect(subject.create(payload)).to be true
      end
    end
  end
end
