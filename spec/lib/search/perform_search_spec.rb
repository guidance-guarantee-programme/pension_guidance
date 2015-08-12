RSpec.describe Search::PerformSearch do
  let(:query) { double }
  let(:page) { '1' }
  let(:per_page) { '10' }

  subject(:searcher) { described_class.new(query, page: page, per_page: per_page) }

  describe '#initialize' do
    it 'assigns the passed in query' do
      expect(subject.send(:query)).to eql(query)
    end

    it 'assigns the passed in page value coerced to an integer' do
      expect(subject.send(:page)).to eql(page.to_i)
    end

    it 'assigns the passed in per_page value coerced to an integer' do
      expect(subject.send(:per_page)).to eql(per_page.to_i)
    end
  end

  describe '#page' do
    subject { searcher.page }

    context 'when page value is a string' do
      let(:page) { '1' }

      it { is_expected.to eq(1) }
    end

    context 'when page value has no value' do
      let(:page) { nil }

      it { is_expected.to eq(described_class::DEFAULT_PAGE) }
    end

    context 'when page value is 0' do
      let(:page) { '0' }

      it { is_expected.to eq(1) }
    end

    context 'when page value is greater than the page limit' do
      let(:page) { '20' }

      it { is_expected.to eq(described_class::PAGE_LIMIT) }
    end

    context '#page is below zero' do
      let(:page) { -1 }

      it { is_expected.to eq(described_class::DEFAULT_PAGE) }
    end
  end

  describe '#per_page' do
    subject { searcher.per_page }

    context 'when per_page value is a string' do
      let(:per_page) { '10' }

      it { is_expected.to eq(10) }
    end

    context 'when per_page has no value' do
      it { is_expected.to eq(described_class::DEFAULT_PER_PAGE) }
    end

    context 'when per_page value is greater than PER_PAGE_LIMIT' do
      let(:per_page) { '50' }

      it { is_expected.to eq(described_class::DEFAULT_PER_PAGE) }
    end
  end

  describe '#call' do
    let(:query) { double }
    let(:total_results) { double }
    let(:item_id) { double }
    let(:item_data_without_id) { { foo: :bar } }
    let(:item_data) { { id: item_id, foo: :bar } }
    let(:items) { [item_data] }
    let(:options) do
      {
        total_results: total_results,
        page: page.to_i,
        per_page: per_page.to_i,
        query: query
      }
    end

    before do
      allow(subject).to receive_messages(items: items,
                                         total_results: total_results)
    end

    it 'instantiates a Search::SearchResultCollection with the correct options' do
      expect(Search::SearchResultCollection).to receive(:new).with(options).and_call_original

      subject.call
    end

    it 'instantiates a Search::SearchResult with each element of #items' do
      expect(Search::SearchResult).to receive(:new).with(item_id, item_data_without_id).and_call_original

      subject.call
    end

    it 'returns a Search::SearchResultCollection' do
      expect(subject.call).to be_a(Search::SearchResultCollection)
    end

    context 'when the item data is valid' do
      before do
        allow_any_instance_of(Search::SearchResult).to receive(:valid?) { true }
      end

      context 'the returned Search::SearchResultCollection#items' do
        it 'contains a corresponding Search::SearchResult' do
          expect(subject.call.items.first).to be_a(Search::SearchResult)
        end

        it 'contains a corresponding Search::SearchResult with matching ID' do
          expect(subject.call.items.first.id).to eq item_id
        end
      end
    end

    context 'when the item data is valid' do
      before do
        allow_any_instance_of(Search::SearchResult).to receive(:valid?) { false }
      end

      context 'the returned Search::SearchResultCollection#items' do
        it 'is empty' do
          expect(subject.call.items).to be_empty
        end
      end
    end
  end
end
