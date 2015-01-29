RSpec.describe Guide, type: :model do
  subject(:guide) { Guide.new(id, source) }

  let(:id) { 'govspeak' }

  describe '#slug' do
    let(:id) { 'a_pension_guide' }
    let(:source) { double }

    it 'returns a slug for the guide' do
      expect(guide.slug).to eq('a-pension-guide')
    end
  end

  describe '#title' do
    subject(:title) { guide.title }

    context 'when the guide has no level one headers' do
      let(:source) { '## No level one headers' }

      it { is_expected.to be_blank }
    end

    context 'when the guide has a level one header' do
      let(:source) { '# Level one header' }

      it 'returns the the level one header' do
        is_expected.to eq 'Level one header'
      end
    end

    context 'when the guide has many level one headers' do
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
    subject(:content) { guide.content }

    let(:source) { File.read(File.expand_path("../../fixtures/#{id}.md", __FILE__)) }
    let(:html) { Govspeak::Document.new(source).to_sanitized_html }

    it 'returns sanitized HTML' do
      is_expected.to eq html
    end
  end
end
