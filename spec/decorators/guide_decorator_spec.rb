require_relative './shared_examples_for_a_guide_decorator'

RSpec.describe GuideDecorator, type: :decorator do
  it_behaves_like 'a guide decorator'

  describe 'subclasses' do
    subject(:decorator) { described_class.new(double) }

    specify 'must implement #title' do
      expect { decorator.title }.to raise_error
    end

    specify 'must implement #description' do
      expect { decorator.description }.to raise_error
    end
  end

  describe '.for' do
    let(:guide) { Guide.new('test-guide', content_type: content_type) }

    subject(:decorator) { GuideDecorator.for(guide) }

    context 'given a govspeak guide' do
      let(:content_type) { :govspeak }

      it { is_expected.to be_a(GovspeakGuideDecorator) }
    end

    context 'given an HTML guide' do
      let(:content_type) { :html }

      it { is_expected.to be_a(HTMLGuideDecorator) }
    end
  end

  describe '#label' do
    let(:guide) { Guide.new('test-guide', label: label) }

    subject { described_class.new(guide).label }

    context 'when the guide specifies a label' do
      let(:label) { 'Document label' }

      it 'returns the label' do
        is_expected.to eq(label)
      end
    end

    context 'when the guide specifies a blank label' do
      let(:label) { '' }

      it 'returns the title' do
        expect { subject }.to raise_error('GuideDecorator subclasses must implement title')
      end
    end

    context 'when the guide specifies no label' do
      let(:label) { nil }

      it 'returns the title' do
        expect { subject }.to raise_error('GuideDecorator subclasses must implement title')
      end
    end
  end
end
