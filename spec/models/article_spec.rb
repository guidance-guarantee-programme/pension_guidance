RSpec.describe Article, type: :model do
  subject(:article) { Article.new(id, source) }

  let(:id) { 'govspeak' }

  describe '#title' do
    subject(:title) { article.title }

    context 'when the article has no level one headers' do
      let(:source) { '## No level one headers' }

      it { is_expected.to be_blank }
    end

    context 'when the article has a level one header' do
      let(:source) { '# Level one header' }

      it 'returns the the level one header' do
        is_expected.to eq 'Level one header'
      end
    end

    context 'when the article has many level one headers' do
      let(:source) do
        <<-GOVSPEAK.strip_heredoc
          # First level one header
          # Second level one header
        GOVSPEAK
      end

      it 'returns the first level one header' do
        is_expected.to eq 'First level one header'
      end
    end
  end

  describe '#content' do
    subject(:content) { article.content }

    let(:source) { File.read(File.expand_path("../../fixtures/#{id}.md", __FILE__)) }
    let(:html) { Govspeak::Document.new(source).to_sanitized_html }

    it 'returns sanitized HTML' do
      is_expected.to eq html
    end
  end

end
