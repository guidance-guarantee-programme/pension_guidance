RSpec.describe Search::GoogleCustomSearchEngine do
  let(:connection) { double }
  let(:cx) { double }
  let(:key) { double }
  let(:mapped_response) { double }
  let(:mapper) { double }

  subject(:custom_search_engine) { described_class.new(key, cx) }

  before do
    allow(Registry).to receive(:[]).with(:google_api_connection) { connection }

    allow_any_instance_of(described_class::ResponseMapper)
      .to receive(:mapped_response).and_return(mapped_response)
  end

  describe '#perform' do
    let(:query) { double }
    let(:page) { 1 }
    let(:per_page) { 10 }

    subject(:perform_search) { custom_search_engine.perform(query, page, per_page) }

    context 'when there is an error' do
      before do
        allow(connection).to receive(:get).and_raise(HTTPConnection::ClientError)
      end

      it 'raises a request error' do
        expect { perform_search }.to raise_error(described_class::RequestError)
      end
    end

    context 'when the request is successful' do
      before do
        allow(connection).to receive(:get) { double(body: {}) }
      end

      it 'returns the mapped response' do
        expect(perform_search).to eq(mapped_response)
      end
    end
  end
end
