require 'spec_helper'

RSpec.describe BookingLocations::Api, :vcr do
  let(:id) { '9d7c72fc-0c74-4418-8099-e1a4e704cb01' }

  subject { described_class.new }

  describe '#get' do
    context 'when the location is found' do
      it 'yields to the given block' do
        subject.get(id) do |response|
          expect(response).to be
        end
      end
    end

    context 'when the location is not found' do
      it 'returns nil' do
        expect(subject.get('whoops')).to be_nil
      end
    end

    context 'when the request timeout is exceeded' do
      pending 'add a test for this'
    end
  end
end
