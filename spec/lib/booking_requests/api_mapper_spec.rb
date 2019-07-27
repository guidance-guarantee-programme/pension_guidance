RSpec.describe BookingRequests::ApiMapper do
  let(:booking_location_id) { SecureRandom.uuid }
  let(:location_id) { SecureRandom.uuid }
  let(:booking_request) do
    allow(BookingLocations).to receive(:find).and_return(double(id: booking_location_id))

    BookingRequestForm.new(
      location_id,
      start_at: '2016-01-01 09:00 UTC',
      first_name: 'Lucius',
      last_name: 'Needful',
      email: 'lucius@example.com',
      telephone_number: '0208 244 3987',
      memorable_word: 'meseeks',
      date_of_birth: '1951-01-01',
      accessibility_requirements: false,
      additional_info: nil,
      gdpr_consent: 'yes',
      dc_pot: 'yes',
      where_you_heard: '1',
      pension_provider: 'aviva'
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
          gdpr_consent: 'yes',
          defined_contribution_pot_confirmed: true,
          where_you_heard: '1',
          pension_provider: 'aviva',
          slots: [
            { priority: 1, date: '2016-01-01', from: '0900', to: '1000' }
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
