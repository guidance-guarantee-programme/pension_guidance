RSpec.describe Calculators::GuaranteedIncomeForm do
  subject(:form) { described_class.new(params) }

  let(:pot) { 100_000 }
  let(:age) { 55 }
  let(:params) { { pot: pot, age: age } }

  it { is_expected.to validate_presence_of(:pot) }
  it { is_expected.to validate_presence_of(:age) }
  it { is_expected.to validate_numericality_of(:pot).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:age).is_greater_than_or_equal_to(55) }
  it { is_expected.to validate_numericality_of(:age).is_less_than_or_equal_to(75) }

  context 'when the form values contain separating characters' do
    let(:pot) { '100,000' }
    let(:age) { '5,5' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.age).to eq('55')
    end
  end

  context 'when the form values contain whitespace' do
    let(:pot) { '       100,000 ' }
    let(:age) { '   55 ' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.age).to eq('55')
    end
  end

  context 'when the form values that can not be coerced' do
    let(:pot) { 'one hundred thousand' }
    let(:age) { '56' }

    it { is_expected.to be_invalid }

    it 'maintains the original values' do
      expect(form.pot).to eq(pot)
      expect(form.age).to eq(age)
    end
  end

  describe '#estimate' do
    subject { form.estimate }

    let(:calculator) { double(GuaranteedIncomeCalculator, estimate: estimate) }
    let(:estimate) { double }

    it 'returns the calculated estimate' do
      expect(GuaranteedIncomeCalculator).to receive(:new).with(pot: pot, age: age) { calculator }

      is_expected.to eq(estimate)
    end
  end
end
