RSpec.describe BookingRequests do
  let(:api) { object_double(BookingRequests::Api.new) }

  describe '.create' do
    context 'with a valid booking request' do
      let(:booking_request) { Hash[blah: 'welp'] }
      let(:result) { {} }

      around do |example|
        with_stubbed_booking_requests_api(api, example)
      end

      before do
        allow(BookingRequests::ApiMapper).to receive(:map).with(booking_request).and_return(result)
        allow(api).to receive(:create).with(result).and_return(true)
      end

      it 'maps to the required API payload' do
        expect(BookingRequests::ApiMapper).to receive(:map).with(booking_request).and_return(result)

        BookingRequests.create(booking_request)
      end

      it 'sends the payload via the API' do
        expect(api).to receive(:create).with(result).and_return(true)

        BookingRequests.create(booking_request)
      end
    end
  end
end
