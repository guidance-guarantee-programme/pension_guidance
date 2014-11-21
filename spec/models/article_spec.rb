RSpec.describe Article, type: :model do
  subject(:article) { Article.new('govspeak') }

  describe '#title' do
    subject(:title) { article.title }

    before do
      expect(article).to receive(:govspeak).and_return(document)
    end

    context 'when the article has no level one headers' do
      let(:document) { Govspeak::Document.new('## No level one headers') }

      it { is_expected.to be_empty }
    end

    context 'when the article has a level one header' do
      let(:document) { Govspeak::Document.new('# Level one header') }

      it { is_expected.to eq 'Level one header' }
    end

    context 'when the article has many level one headers' do
      let(:document) do
        Govspeak::Document.new <<-GOVSPEAK.strip_heredoc
          # First level one header
          # Second level one header
        GOVSPEAK
      end

      it { is_expected.to eq 'First level one header' }
    end
  end

  describe '#content' do
    subject(:content) { article.content }

    let(:govspeak) { Pathname.new(__FILE__).dirname.parent.join('fixtures', "#{article.id}.md") }
    let(:html) { File.read Pathname.new(__FILE__).dirname.parent.join('fixtures', "#{article.id}.html") }

    before do
      expect(article).to receive(:viewpath).at_least(:once).and_return(govspeak)
    end

    specify { expect(content).to eq html }
  end

  describe '#==' do
    specify { expect(article).to eq Article.new('govspeak') }
    specify { expect(article).to_not eq Article.new('other') }
  end

  describe '.find' do
    subject(:find) { Article.find(id) }

    context 'non-existent article' do
      let(:id) { 'does-not-exist' }

      specify { expect { find }.to raise_error(Article::ArticleNotFound) }
    end

    context 'existing article' do
      let(:id) { 'govspeak' }
      let(:govspeak) { Pathname.new(__FILE__).dirname.parent.join('fixtures', "#{id}.md") }

      before do
        expect_any_instance_of(Article).to receive(:viewpath).and_return(govspeak)
      end

      it 'returns the article' do
        expect(find).to eq article
      end
    end
  end

  context 'the article view does not exist' do
    before { expect(article).to receive(:viewpath).and_return(Pathname.new('does-not-exist')) }

    describe '#title' do
      subject(:title) { article.title }

      specify { expect { title }.to raise_error(Article::ArticleNotFound) }
    end

    describe '#content' do
      subject(:content) { article.content }

      specify { expect { content }.to raise_error(Article::ArticleNotFound) }
    end
  end
end
