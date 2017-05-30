RSpec.describe BookingRequests do
  let(:api) { instance_double(BookingRequests::Api) }

  describe '.slots' do
    before do
      BookingRequests.api = api
      allow(api).to receive(:slots).and_return(
        [{ 'date' => '2017-06-02', 'start' => '0900', 'end' => '1300' }]
      )
    end

    it 'returns slots for the calendar' do
      response = BookingRequests.slots('ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef')

      expect(response.first).to include(
        'Friday, Jun  2 - Morning',
        '2017-06-02-0900-1300'
      )
    end
  end

  describe '.create' do
    context 'with a valid booking request' do
      let(:booking_request) { Hash[blah: 'welp'] }
      let(:result) { Hash.new }

      before do
        BookingRequests.api = api
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
