RSpec.describe Article, type: :model do
  subject(:article) { Article.new(id, source) }

  let(:id) { 'govspeak' }

  describe '#title' do
    subject(:title) { article.title }

    context 'when the article has no level one headers' do
      let(:source) { '## No level one headers' }

      it { is_expected.to be_empty }
    end

    context 'when the article has a level one header' do
      let(:source) { '# Level one header' }

      it { is_expected.to eq 'Level one header' }
    end

    context 'when the article has many level one headers' do
      let(:source) do
        <<-GOVSPEAK.strip_heredoc
          # First level one header
          # Second level one header
        GOVSPEAK
      end

      it { is_expected.to eq 'First level one header' }
    end
  end

  describe '#content' do
    subject(:content) { article.content }

    let(:source) { File.read Pathname.new(__FILE__).dirname.parent.join('fixtures', "#{id}.md") }
    let(:html) { File.read Pathname.new(__FILE__).dirname.parent.join('fixtures', "#{id}.html") }

    it { is_expected.to eq html }
  end

  describe '#==' do
    let(:source) { 'source' }

    specify { expect(article).to eq Article.new('govspeak', source) }
    specify { expect(article).to_not eq Article.new('other', source) }
  end
end
