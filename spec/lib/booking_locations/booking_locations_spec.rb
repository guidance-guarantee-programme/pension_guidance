require 'spec_helper'

RSpec.describe BookingLocations do
  describe '.find' do
    context 'when the location is present' do
      let(:api) { instance_double(BookingLocations::Api) }
      let(:id) { '9d7c72fc-0c74-4418-8099-e1a4e704cb01' }
      let(:response) { Hash.new }

      before do
        BookingLocations.api = api
        allow(api).to receive(:get).with(id).and_yield(response)
      end

      it 'returns the `Location`' do
        expect(BookingLocations.find(id)).to be_a(BookingLocations::Location)
      end
    end
  end
end
