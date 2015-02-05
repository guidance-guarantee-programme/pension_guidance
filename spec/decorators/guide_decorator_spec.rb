RSpec.describe GuideDecorator, type: :decorator do
  subject(:guide) { described_class.new(instance_double(Guide, source: double)) }

  it { is_expected.to respond_to(:slug) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:content) }

  before do
    allow(File).to receive(:extname) { extname }
    allow(File).to receive(:read) { source }
  end

  context 'when the guide source is markdown formatted' do
    let(:extname) { '.md' }

    describe '#title' do
      subject(:title) { guide.title }

      context 'when the guide has no level one headers' do
        let(:source) { '## No level one headers' }

        it { is_expected.to be_blank }
      end

      context 'when the guide has a level one header' do
        let(:source) { '# Level one header' }

        it 'returns the the level one header' do
          is_expected.to eq('Level one header')
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
          is_expected.to eq('First level one header')
        end
      end
    end

    describe '#content' do
      subject(:content) { guide.content }

      let(:source) do
        <<-GOVSPEAK.strip_heredoc
          # First level one header

          Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        GOVSPEAK
      end

      it 'returns sanitized HTML' do
        expected_html = <<-HTML.strip_heredoc
          <h1 id="first-level-one-header">First level one header</h1>

          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        HTML

        is_expected.to eq(expected_html)
      end
    end
  end

  context 'when the guide source is HTML formatted' do
    let(:extname) { '.html' }

    describe '#title' do
      subject(:title) { guide.title }

      context 'when the guide has no level one headers' do
        let(:source) { '<h2>No level one headers</h2>' }

        it { is_expected.to be_blank }
      end

      context 'when the guide has a level one header' do
        let(:source) { '<h1>Level one header</h1>' }

        it 'returns the the level one header' do
          is_expected.to eq('Level one header')
        end
      end

      context 'when the guide has many level one headers' do
        let(:source) do
          <<-HTML.strip_heredoc
          <h1>First level one header</h1>
          <h1>Second level one header</h1>
          HTML
        end

        it 'returns the first level one header' do
          is_expected.to eq('First level one header')
        end
      end
    end

    describe '#content' do
      subject(:content) { guide.content }

      let(:source) do
        <<-HTML.strip_heredoc
          <h1>First level one header</h1>

          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        HTML
      end

      it 'returns the HTML' do
        is_expected.to eq(source)
      end
    end
  end
end
