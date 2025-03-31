RSpec.describe CachedGuideDecorator do
  let(:id) { 'id' }
  let(:locale) { 'en' }
  let(:title) { 'title' }
  let(:content) { 'content' }
  let(:cache) { double }
  let(:decorator) do
    double(id: id, locale: locale, title: title, content: content, slug: '', description: '', label: '', url: '')
  end

  subject(:cached_decorator) { described_class.new(decorator, cache, '10') }

  describe '#title' do
    it 'uses the correct cache key and expiration' do
      expect(cache).to receive(:fetch).with("#{id}-#{locale}-#{title}", expires_in: 10)
      cached_decorator.title
    end

    context 'when the cache key does not exist' do
      before do
        allow(decorator).to receive(:title).and_return(title)
        allow(cache).to receive(:fetch) do |_key, &block|
          block.call
        end
      end

      it 'calls the decorator' do
        expect(decorator).to receive(:title)
        cached_decorator.title
      end

      it 'returns the value' do
        expect(cached_decorator.title).to eq(title)
      end
    end

    context 'when the cache key exists' do
      before do
        allow(cache).to receive(:fetch).and_return(title)
      end

      it 'does not call the decorator' do
        expect(decorator).to_not receive(:title)
        cached_decorator.title
      end

      it 'returns the cached value' do
        expect(cached_decorator.title).to eq(title)
      end
    end
  end

  describe '#content' do
    it 'uses the correct cache key and expiration' do
      expect(cache).to receive(:fetch).with("#{id}-#{locale}-#{content}", expires_in: 10)
      cached_decorator.content
    end

    context 'when the cache key does not exist' do
      before do
        allow(decorator).to receive(:content).and_return(content)
        allow(cache).to receive(:fetch) do |_key, &block|
          block.call
        end
      end

      it 'calls the decorator' do
        expect(decorator).to receive(:content)
        cached_decorator.content
      end

      it 'returns the value' do
        expect(cached_decorator.content).to eq(content)
      end
    end

    context 'when the cache key exists' do
      before do
        allow(cache).to receive(:fetch).and_return(content)
      end

      it 'does not call the decorator' do
        expect(decorator).to_not receive(:content)
        cached_decorator.content
      end

      it 'returns the cached value' do
        expect(cached_decorator.content).to eq(content)
      end
    end
  end

  %i[id slug description label url].each do |attribute|
    describe "##{attribute}" do
      it 'does not call the cache' do
        expect(cache).to_not receive(:fetch)
        cached_decorator.public_send(attribute)
      end

      it 'calls the decorator' do
        expect(decorator).to receive(attribute)
        cached_decorator.public_send(attribute)
      end
    end
  end
end
