RSpec.describe BookingRequests::ApiMapper do
  let(:booking_location_id) { SecureRandom.uuid }
  let(:location_id) { SecureRandom.uuid }
  let(:booking_request) do
    allow(BookingLocations).to receive(:find).and_return(double(id: booking_location_id))

    BookingRequestForm.new(
      location_id,
      primary_slot: '2016-01-01-0900-1300',
      secondary_slot: '2016-01-01-1300-1700',
      tertiary_slot: '',
      first_name: 'Lucius',
      last_name: 'Needful',
      email: 'lucius@example.com',
      telephone_number: '0208 244 3987',
      memorable_word: 'meseeks',
      date_of_birth: '1951-01-01',
      accessibility_requirements: false,
      additional_info: nil,
      opt_in: false,
      dc_pot: 'yes',
      remote_ip: '127.0.0.1'
    )
  end

  context 'mapping the booking_request form' do
    subject { described_class.map(booking_request) }

    it 'maps from the `BookingRequestForm` to requisite payload' do
      expect(subject).to eq(
        booking_request: {
          booking_location_id: booking_location_id,
          location_id: location_id,
          name: 'Lucius Needful',
          email: 'lucius@example.com',
          phone: '0208 244 3987',
          memorable_word: 'meseeks',
          age_range: '55-plus',
          date_of_birth: '1951-01-01',
          accessibility_requirements: false,
          additional_info: '',
          marketing_opt_in: false,
          defined_contribution_pot_confirmed: true,
          placed_by_agent: false,
          slots: [
            { priority: 1, date: '2016-01-01', from: '0900', to: '1300' },
            { priority: 2, date: '2016-01-01', from: '1300', to: '1700' }
          ]
        }
      )
    end
  end

  context 'coerces the `dc_pot` strings to booleans' do
    it 'coerces `yes` to true' do
      expect(described_class.dc_pot_as_boolean('yes')).to be true
    end

    it 'coerces `not-sure` to false' do
      expect(described_class.dc_pot_as_boolean('not-sure')).to be false
    end
  end
end
