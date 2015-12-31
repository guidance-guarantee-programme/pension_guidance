require_relative './shared_examples_for_a_guide_decorator'

RSpec.describe HTMLGuideDecorator, type: :decorator do
  it_behaves_like 'a guide decorator'

  subject(:guide) { described_class.new(instance_double(Guide, content: guide_content, content_type: :html)) }

  describe '#title' do
    subject(:title) { guide.title }

    context 'when the guide has no level one headers' do
      let(:guide_content) { '<h2>No level one headers</h2>' }

      it { is_expected.to be_blank }
    end

    context 'when the guide has a level one header' do
      let(:guide_content) { '<h1>Level one header</h1>' }

      it 'returns the the level one header' do
        is_expected.to eq('Level one header')
      end
    end

    context 'when the guide has many level one headers' do
      let(:guide_content) do
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

    let(:guide_content) do
      <<-HTML.strip_heredoc
        <h1>First level one header</h1>

        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      HTML
    end

    it 'returns the HTML with automatic generation of header IDs' do
      expected_html = <<-HTML.strip_heredoc
        <h1 id="first-level-one-header">First level one header</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      HTML

      is_expected.to eq(expected_html)
    end
  end

  describe '#headers' do
    let(:guide_content) do
      <<-HTML.strip_heredoc
        <h1>First level one header</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        <h2>In mauris risus, elementum ut</h2>
        <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
        <h2 id="custom-identifier">Suspendisse scelerisque molestie vehicula</h2>
        <p>Cras ut suscipit felis, vulputate viverra orci. Cras ornare sagittis diam.</p>
      HTML
    end

    context 'when no level is specified' do
      subject(:headers) { guide.headers }

      it 'returns an array of first level headers' do
        expect(headers).to eq('first-level-one-header' => 'First level one header')
      end
    end

    context 'when a level is specified' do
      subject(:headers) { guide.headers(2) }

      it 'returns an array of headers at that level' do
        expect(headers).to eq('in-mauris-risus-elementum-ut' => 'In mauris risus, elementum ut',
                              'custom-identifier' => 'Suspendisse scelerisque molestie vehicula')
      end
    end
  end
end
