require 'securerandom'

RSpec.describe 'POST /locations/:id/booking-request/complete', type: :request do
  context 'with valid params' do
    it 'creates the booking via the API' do
      location_id = SecureRandom.uuid
      payload = {
        booking_request: {
          primary_slot: '2016-01-01-0900-1300',
          secondary_slot: '2016-01-01-1300-1700',
          tertiary_slot: '2016-01-02-0900-1300',
          first_name: 'Lucius',
          last_name: 'Needful',
          email: 'lucius@example.com',
          telephone_number: '0208 244 3987',
          memorable_word: 'meseeks',
          appointment_type: '55-plus',
          accessibility_requirements: '0',
          opt_in: '0',
          dc_pot: '1'
        }
      }

      expect(BookingRequests).to receive(:create).with(kind_of(BookingRequestForm))

      post booking_request_complete_location_path(id: location_id), payload
    end
  end
end
