RSpec.describe GuideDecorator, type: :decorator do
  describe 'delegates' do
    let(:id) { 'foo' }
    let(:slug) { '/foo' }
    let(:description) { 'The test description' }
    let(:decorator) { described_class.new(instance_spy(Guide, id: id, slug: slug, description: description)) }

    describe '#id' do
      subject { decorator.id }

      it { is_expected.to eq(id) }
    end

    describe '#slug' do
      subject { decorator.slug }

      it { is_expected.to eq(slug) }
    end

    describe '#description' do
      subject { decorator.description }

      it { is_expected.to eq(description) }
    end
  end

  context 'when the guide content is markdown formatted' do
    subject(:guide) { described_class.new(instance_double(Guide, content: guide_content, content_type: :govspeak)) }

    describe '#title' do
      subject(:title) { guide.title }

      context 'when the guide has no level one headers' do
        let(:guide_content) { '## No level one headers' }

        it { is_expected.to be_blank }
      end

      context 'when the guide has a level one header' do
        let(:guide_content) { '# Level one header' }

        it 'returns the the level one header' do
          is_expected.to eq('Level one header')
        end
      end

      context 'when the guide has many level one headers' do
        let(:guide_content) do
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

      let(:guide_content) do
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

  context 'when the guide content is HTML formatted' do
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
end
