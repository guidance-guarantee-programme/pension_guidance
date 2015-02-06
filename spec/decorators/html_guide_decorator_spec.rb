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

    it 'returns the HTML' do
      is_expected.to eq(guide_content)
    end
  end
end
