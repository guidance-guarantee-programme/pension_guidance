RSpec.describe JourneyDecorator do
  let(:journey_guides) do
    1.upto(3).map { |id| double(id: id, content_type: :html) }
  end
  let(:current_guide) { journey_guides[1] }

  subject(:collection) { described_class.decorate(journey_guides, current_guide) }

  specify { collection.each { |item| expect(item).to be_a(described_class) } }

  describe '#guide' do
    let(:decorated_guide) { double }

    before do
      allow(GuideDecorator).to receive(:cached_for).and_return(decorated_guide)
    end

    specify { expect(collection[0].guide).to eq(decorated_guide) }
  end

  describe '#==' do
    specify { expect(collection[0]).to eq(journey_guides[0]) }
    specify { expect(collection[0]).to_not eq(journey_guides[1]) }
  end

  describe '#previous_step' do
    specify { expect(collection[0].previous_step).to be_nil }
    specify { expect(collection[1].previous_step).to eq(collection[0]) }
    specify { expect(collection[1].previous_step.index).to eq(1) }
  end

  describe '#next_step' do
    specify { expect(collection[2].next_step).to be_nil }
    specify { expect(collection[1].next_step).to eq(collection[2]) }
    specify { expect(collection[1].next_step.index).to eq(3) }
  end

  describe '#index' do
    specify { expect(collection.map(&:index)).to eq([1, 2, 3]) }
  end

  describe '#current?' do
    specify { expect(collection.map(&:current?)).to eq([false, true, false]) }
  end

  describe '#first?' do
    specify { expect(collection.map(&:first?)).to eq([true, false, false]) }
  end

  describe '#last?' do
    specify { expect(collection.map(&:last?)).to eq([false, false, true]) }
  end

  describe '#li_classes' do
    specify do
      expect(collection.map(&:li_classes)).to \
        eq([%w(), %w(is-current), %w(last-child)])
    end

    context 'when current guide is last in the journey' do
      let(:current_guide) { journey_guides.last }

      specify { expect(collection.last.li_classes).to eq(%w(last-child is-current)) }
    end
  end

  describe '#a_classes' do
    specify do
      expect(collection.map(&:a_classes)).to \
        eq([%w(t-journey-nav-step),
            %w(t-journey-nav-step t-journey-nav__current-step),
            %w(t-journey-nav-step)])
    end
  end

  describe '#sub_nav' do
    before do
      allow(current_guide).to receive(:id).and_return('pension-pot-options')
    end

    specify { expect(collection[0].sub_nav).to be_nil }
    specify { expect(collection[1].sub_nav).to include('t-journey-subnav-step') }
  end
end
