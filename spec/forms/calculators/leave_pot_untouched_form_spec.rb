RSpec.describe Calculators::LeavePotUntouchedForm, type: :model do
  subject(:form) { described_class.new(params) }

  let(:pot) { 1_000 }
  let(:contribution) { 200 }
  let(:params) { { pot: pot, contribution: contribution } }

  it { is_expected.to validate_presence_of(:pot) }
  it { is_expected.to validate_numericality_of(:pot).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:contribution).is_greater_than_or_equal_to(0) }

  context 'when the form values contain separating characters' do
    let(:pot) { '100,000' }
    let(:contribution) { '1,000' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.contribution).to eq('1000')
    end
  end

  context 'when the form values contain whitespace' do
    let(:pot) { '       100,000 ' }
    let(:contribution) { '   1,000 ' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.contribution).to eq('1000')
    end
  end

  context 'when the form values that can not be coerced' do
    let(:pot) { 'one hundred thousand' }
    let(:contribution) { '£1000' }

    it { is_expected.to be_invalid }

    it 'maintains the original values' do
      expect(form.pot).to eq(pot)
      expect(form.contribution).to eq(contribution)
    end
  end

  describe '#estimate' do
    subject { form.estimate }

    let(:calculator) { double(LeavePotUntouchedCalculator, estimate: estimate) }
    let(:estimate) { double }

    it 'returns the calculated result' do
      expect(LeavePotUntouchedCalculator).to receive(:new).with(pot: pot, contribution: contribution) { calculator }

      is_expected.to eq(estimate)
    end
  end
end
