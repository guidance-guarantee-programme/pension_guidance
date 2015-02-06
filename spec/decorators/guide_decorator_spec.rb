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
end
