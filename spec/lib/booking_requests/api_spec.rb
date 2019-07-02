require 'securerandom'

RSpec.describe BookingRequests::Api, :vcr do
  let(:payload) do
    {
      booking_request: {
        booking_location_id: 'ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef',
        location_id: 'ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef',
        name: 'Lucius Needful',
        email: 'lucius@example.com',
        phone: '0208 244 3987',
        memorable_word: 'meseeks',
        date_of_birth: '1950-01-01',
        age_range: '55-plus',
        accessibility_requirements: false,
        defined_contribution_pot_confirmed: true,
        gdpr_consent: 'yes',
        slots: [
          { priority: 1, date: '2019-07-18', from: '0830', to: '0930' }
        ]
      }
    }
  end

  subject { described_class.new }

  describe '#create' do
    context 'when the request is successful' do
      it 'returns truthy' do
        expect(subject.create(payload)).to be_truthy
      end
    end
  end

  describe '#slots' do
    it 'returns slots for the given location' do
      slots = subject.slots('ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef')

      expect(slots).to eq(
        '2019-07-26' => [
          '2019-07-26T11:00:00.000Z',
          '2019-07-26T12:00:00.000Z',
          '2019-07-26T14:30:00.000Z'
        ]
      )
    end
  end
end
