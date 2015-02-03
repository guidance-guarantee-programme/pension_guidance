RSpec.describe GuideDecorator, type: :decorator do
  subject(:decorated_guide) { described_class.new(guide) }

  let(:guide) { instance_double(Guide) }

  it { is_expected.to respond_to(:slug) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:content) }

  describe '#title' do
    before do
      allow(guide).to receive(:source) { source }
    end

    subject(:title) { decorated_guide.title }

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
    before do
      allow(guide).to receive(:source) { source }
    end

    subject(:content) { decorated_guide.content }

    let(:source) { File.read(File.expand_path('../../fixtures/the_test_guide.md', __FILE__)) }
    let(:html) { Govspeak::Document.new(source).to_sanitized_html }

    it 'returns sanitized HTML' do
      is_expected.to eq(html)
    end
  end
end
