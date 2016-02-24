RSpec.describe Calculators::AdjustableIncomeForm do
  subject(:form) { described_class.new(params) }

  let(:pot) { 100_000 }
  let(:desired_monthly_income) { 500 }
  let(:age) { 55 }
  let(:params) { { pot: pot, desired_monthly_income: desired_monthly_income, age: age } }

  it { is_expected.to validate_presence_of(:pot) }
  it { is_expected.to validate_numericality_of(:pot).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:desired_monthly_income).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:desired_monthly_income).is_less_than(pot) }
  it { is_expected.to validate_numericality_of(:age).is_greater_than_or_equal_to(55) }

  context 'when the form values contain separating characters' do
    let(:pot) { '100,000' }
    let(:desired_monthly_income) { '5,00' }
    let(:age) { '5,5' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.desired_monthly_income).to eq('500')
      expect(form.age).to eq('55')
    end
  end

  context 'when the form values contain whitespace' do
    let(:pot) { '      100000  ' }
    let(:desired_monthly_income) { '  500    ' }
    let(:age) { '  55   ' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.desired_monthly_income).to eq('500')
      expect(form.age).to eq('55')
    end
  end

  context 'when the form values that can not be coerced' do
    let(:pot) { 'one hundred thousand' }
    let(:desired_monthly_income) { 'half a grand' }
    let(:age) { '55' }

    it { is_expected.to be_invalid }

    it 'maintains the original values' do
      expect(form.pot).to eq(pot)
      expect(form.desired_monthly_income).to eq(desired_monthly_income)
      expect(form.age).to eq(age)
    end
  end

  describe '#estimate' do
    subject { form.estimate }

    let(:calculator) { double(AdjustableIncomeCalculator, estimate: estimate) }
    let(:estimate) { double }

    it 'returns the calculated result' do
      expect(AdjustableIncomeCalculator).to receive(:new).with(pot: pot,
                                                               desired_income: desired_monthly_income * 12,
                                                               age: age) { calculator }

      is_expected.to eq(estimate)
    end
  end
end
