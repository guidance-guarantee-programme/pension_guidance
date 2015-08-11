require 'webmock/rspec'

RSpec.describe Switchboard, '.lookup' do
  let(:id) { '123' }

  subject(:lookup) { described_class.lookup(id) }

  context 'when the environment variable has not been set' do
    it { is_expected.to be_nil }
  end

  context 'when the environment variable has been set' do
    let(:switchboard_base_url) { 'https://switchboard' }
    let(:request_url) { "#{switchboard_base_url}/lookup/#{id}" }
    let(:reponse) { '' }

    before do
      ENV['SWITCHBOARD_BASE_URL'] = switchboard_base_url
    end

    after do
      ENV.delete('SWITCHBOARD_BASE_URL')
    end

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
