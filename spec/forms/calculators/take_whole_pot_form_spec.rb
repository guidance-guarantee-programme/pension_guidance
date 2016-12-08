RSpec.describe Calculators::TakeWholePotForm, type: :model do
  subject(:form) { described_class.new(params) }

  let(:pot) { 100_000 }
  let(:income) { 1_00 }
  let(:params) { { pot: pot, income: income } }

  it { is_expected.to validate_presence_of(:pot) }
  it { is_expected.to validate_numericality_of(:pot).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:income).is_greater_than_or_equal_to(0) }

  context 'when the form values contain separating characters' do
    let(:pot) { '100,000' }
    let(:income) { '10,000' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.income).to eq('10000')
    end
  end

  context 'when the form values contain whitespace' do
    let(:pot) { '       100,000 ' }
    let(:income) { '   10,000 ' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.income).to eq('10000')
    end
  end

  context 'when the form values that can not be coerced' do
    let(:pot) { 'one hundred thousand' }
    let(:income) { '£10000' }

    it { is_expected.to be_invalid }

    it 'maintains the original values' do
      expect(form.pot).to eq(pot)
      expect(form.income).to eq(income)
    end
  end

  describe '#estimate' do
    subject(:estimate) { form.estimate }

    let(:calculator) { double(IncomeTaxCalculator, lump_sum_tax: lump_sum_tax, lump_sum_received: lump_sum_received) }
    let(:lump_sum_tax) { 1_000 }
    let(:lump_sum_received) { 5_000 }

    it 'returns the calculated result' do
      expect(IncomeTaxCalculator).to receive(:new).with(lump_sum: pot, income: income) { calculator }

      expect(estimate.pot_tax).to eq(lump_sum_tax)
      expect(estimate.pot_received).to eq(lump_sum_received)
    end
  end
end
