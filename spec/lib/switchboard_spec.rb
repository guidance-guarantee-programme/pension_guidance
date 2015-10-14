require 'webmock/rspec'

RSpec.describe Switchboard, '.lookup' do
  let(:connection) { nil }
  let(:id) { '123' }

  before do
    Registry[:switchboard_connection] = connection
  end

  subject(:lookup) { described_class.lookup(id) }

  context 'when the connection does not exist' do
    it { is_expected.to be_nil }
  end

  context 'when the connection exists' do
    let(:switchboard_base_url) { 'https://switchboard' }
    let(:connection) { HTTPConnectionFactory.build(switchboard_base_url) }
    let(:request_url) { "#{switchboard_base_url}/lookup/#{id}" }
    let(:reponse) { '' }

    context 'and the lookup is not found' do
      before do
        stub_request(:get, request_url).to_return(status: 404)
      end

      it { is_expected.to be_nil }
    end

    context 'and the lookup is found' do
      before do
        stub_request(:get, request_url).to_return(body: response)
      end

      context 'but invalid JSON is returned' do
        let(:response) { 'invalid' }

        it { is_expected.to be_nil }
      end

      context 'and valid JSON is returned' do
        let(:phone) { '456' }
        let(:response) do
          {
            phone: phone
          }.to_json
        end

        it { is_expected.to eq(phone) }
      end
    end
  end
end
