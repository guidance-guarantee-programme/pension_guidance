RSpec.describe ArticleRepository do
  subject(:article_repository) { ArticleRepository.new(repository) }

  let(:repository) { Pathname.new(File.expand_path('../../fixtures', __FILE__)) }

  describe '#find' do
    subject(:find) { article_repository.find(id) }

    context 'non-existent article' do
      let(:id) { 'does-not-exist' }

      specify { expect { find }.to raise_error(ArticleRepository::ArticleNotFound) }
    end

    context 'existing article' do
      let(:id) { 'govspeak' }

      it 'returns the article' do
        expect(find.id).to eq id
      end
    end
  end

  describe '.find' do
    subject(:find) { ArticleRepository.find(id) }

    let(:id) { 'govspeak' }

    before do
      expect_any_instance_of(ArticleRepository).to receive(:repository).and_return(repository)
    end

    specify { expect(find.id).to eq id }
  end

end
