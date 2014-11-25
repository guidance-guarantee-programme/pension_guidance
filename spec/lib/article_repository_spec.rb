RSpec.describe ArticleRepository do
  subject(:article_repository) { ArticleRepository.new(repository) }

  let(:repository) { Pathname.new(__FILE__).dirname.parent.join('fixtures') }

  describe '#find' do
    subject(:find) { article_repository.find(id) }

    context 'non-existent article' do
      let(:id) { 'does-not-exist' }

      specify { expect { find }.to raise_error(ArticleRepository::ArticleNotFound) }
    end

    context 'existing article' do
      let(:article) { instance_double('Article', id: id)}
      let(:id) { 'govspeak' }

      it 'returns the article' do
        expect(find).to eq article
      end
    end
  end

  describe '.find' do
    subject(:find) { ArticleRepository.find(id) }

    let(:id) { 'govspeak' }
    let(:article) { instance_double('Article', id: id)}

    before do
      expect_any_instance_of(ArticleRepository).to receive(:repository).and_return(repository)
    end

    specify { expect(find).to eq article }
  end

end
