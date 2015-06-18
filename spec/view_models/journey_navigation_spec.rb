RSpec.describe JourneyNavigation do
  subject(:journey_navigation) { JourneyNavigation.new(tree, current_step) }

  let(:current_step) { 'other' }

  let(:foo_guide) { instance_double(Guide, content_type: :govspeak, id: double, slug: 'foo', label: 'Foo') }
  let(:bar_guide) { instance_double(Guide, content_type: :govspeak, id: double, slug: 'bar', label: 'Bar') }
  let(:baz_guide) { instance_double(Guide, content_type: :govspeak, id: double, slug: 'baz', label: 'Baz') }

  let(:tree) do
    Tree::TreeNode.from_hash(
      ['foo', foo_guide] => { ['bar', bar_guide] => { ['baz', baz_guide] => nil } }
    )
  end

  describe '#overview' do
    subject(:overview_step) { journey_navigation.overview }

    it { is_expected.to be_a(JourneyNavigation::Step) }

    it 'is not a current step' do
      expect(overview_step.current).to be_falsey
    end

    it 'has the label of the guide at the root of the tree' do
      expect(overview_step.label).to eq('Foo')
    end

    it 'has the URL of the guide at the root of the tree' do
      expect(overview_step.url).to eq('/foo')
    end

    context 'when the overview is the current guide' do
      let(:current_step) { 'foo' }

      it 'is a current step' do
        expect(overview_step.current).to be_truthy
      end
    end

    context 'when a child step is the current guide' do
      let(:current_step) { 'baz' }

      it 'is a current step' do
        expect(overview_step.current).to be_truthy
      end
    end
  end

  describe '#steps' do
    subject(:steps) { journey_navigation.steps }

    it 'returns steps for each guide' do
      steps.each do |step|
        expect(step).to be_a(JourneyNavigation::Step)
      end
    end

    context 'first step' do
      subject(:first_step) { steps.first }

      it 'has the label of the guide at the root of the tree' do
        expect(first_step.label).to eq('Bar')
      end

      it 'has the URL of the guide at the root of the tree' do
        expect(first_step.url).to eq('/bar')
      end

      context 'when the step is the current guide' do
        let(:current_step) { 'bar' }

        it 'is a current step' do
          expect(first_step.current).to be_truthy
        end
      end

      context 'when a child step is the current guide' do
        let(:current_step) { 'baz' }

        it 'is a current step' do
          expect(first_step.current).to be_truthy
        end
      end
    end
  end

  describe '#active?' do
    context 'when the current step is the root step' do
      let(:current_step) { 'foo' }

      it { is_expected.to_not be_active }
    end

    context 'when the current step is within the tree' do
      let(:current_step) { 'bar' }

      it { is_expected.to be_active }
    end

    context 'when the current step is not within the tree' do
      let(:current_step) { 'other' }

      it { is_expected.to_not be_active }
    end
  end
end
