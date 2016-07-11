RSpec.describe BookingRequests::ApiMapper do
  let(:location_id) { SecureRandom.uuid }
  let(:booking_request) do
    BookingRequestForm.new(
      location_id,
      primary_slot: '2016-01-01-0900-1300',
      secondary_slot: '2016-01-01-1300-1700',
      tertiary_slot: '2016-01-02-0900-1300',
      first_name: 'Lucius',
      last_name: 'Needful',
      email: 'lucius@example.com',
      telephone_number: '0208 244 3987',
      memorable_word: 'meseeks',
      appointment_type: '55-plus',
      accessibility_requirements: false,
      opt_in: false,
      dc_pot: true
    )
  end

  subject { described_class.map(booking_request) }

  it 'maps from the `BookingRequestForm` to requisite payload' do
    expect(subject).to eq(
      booking_request: {
        location_id: location_id,
        name: 'Lucius Needful',
        email: 'lucius@example.com',
        phone: '0208 244 3987',
        memorable_word: 'meseeks',
        age_range: '55-plus',
        accessibility_requirements: false,
        marketing_opt_in: false,
        defined_contribution_pot: true,
        slots: [
          { priority: 1, date: '2016-01-01', from: '0900', to: '1300' },
          { priority: 2, date: '2016-01-01', from: '1300', to: '1700' },
          { priority: 3, date: '2016-01-02', from: '0900', to: '1300' }
        ]
      }
    )
  end
end
