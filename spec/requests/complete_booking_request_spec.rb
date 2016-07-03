require 'securerandom'

RSpec.describe 'POST /locations/:id/booking-request/complete', type: :request do
  context 'with valid params' do
    it 'creates the booking via the API' do
      location_id = SecureRandom.uuid

      expect(BookingRequests).to receive(:create).with(kind_of(BookingRequestForm))

      post booking_request_complete_location_path(id: location_id)
    end
  end
end
