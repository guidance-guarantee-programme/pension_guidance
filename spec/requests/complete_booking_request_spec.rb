require 'securerandom'

RSpec.describe 'POST /locations/:id/booking-request/complete', type: :request do
  context 'with valid params' do
    before do
      # Provide a location name for the breadcrumbs
      allow(BookingLocations).to receive(:find).and_return(double(:booking_location, name_for: 'Breadcrumb'))
    end

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
          date_of_birth: '1940-01-01',
          accessibility_requirements: '0',
          opt_in: '1',
          dc_pot: 'yes'
        }
      }

      expect(BookingRequests).to receive(:create).with(kind_of(BookingRequestForm))

      post booking_request_complete_location_path(id: location_id), params: payload
    end
  end
end
