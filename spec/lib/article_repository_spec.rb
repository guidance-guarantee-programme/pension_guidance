RSpec.describe ArticleRepository do

  describe '.find' do
    subject(:find) { ArticleRepository.find(id) }

    context 'non-existent article' do
      let(:id) { 'does-not-exist' }

      specify { expect { find }.to raise_error(ArticleRepository::ArticleNotFound) }
    end

    context 'existing article' do
      let(:article) { instance_double('Article', id: id)}
      let(:path) { Pathname.new(__FILE__).dirname.parent.join('fixtures', "#{id}.md") }
      let(:id) { 'govspeak' }

      before do
        expect_any_instance_of(ArticleRepository).to receive(:path).with(id).and_return(path)
      end

      it 'returns the article' do
        expect(find).to eq article
      end
    end
  end

end
