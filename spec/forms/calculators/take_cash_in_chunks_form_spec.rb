RSpec.describe Calculators::TakeCashInChunksForm, type: :model do
  subject(:form) { described_class.new(params) }

  let(:pot) { 75_000 }
  let(:income) { 25_000 }
  let(:chunk) { 1_500 }
  let(:params) { { pot: pot, income: income, chunk: chunk } }

  it { is_expected.to validate_presence_of(:pot) }
  it { is_expected.to validate_presence_of(:income) }
  it { is_expected.to validate_presence_of(:chunk) }

  it { is_expected.to validate_numericality_of(:pot).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:income).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:chunk).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:chunk).is_less_than(pot) }

  context 'when the form values contain separating characters' do
    let(:pot) { '100,000' }
    let(:income) { '12,000' }
    let(:chunk) { '1,000' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.income).to eq('12000')
      expect(form.chunk).to eq('1000')
    end
  end

  context 'when the form values contain whitespace' do
    let(:pot) { '       100,000 ' }
    let(:income) { '   12,000 ' }
    let(:chunk) { '   1,000 ' }

    it { is_expected.to be_valid }

    it 'strips them out' do
      expect(form.pot).to eq('100000')
      expect(form.income).to eq('12000')
      expect(form.chunk).to eq('1000')
    end
  end

  context 'when the form values that can not be coerced' do
    let(:pot) { 'one hundred thousand' }
    let(:income) { '£12000' }
    let(:chunk) { '£1000' }

    it { is_expected.to be_invalid }

    it 'maintains the original values' do
      expect(form.pot).to eq(pot)
      expect(form.income).to eq(income)
      expect(form.chunk).to eq(chunk)
    end
  end

  describe '#estimate' do
    subject(:estimate) { form.estimate }

    let(:calculator) { double(IncomeTaxCalculator, lump_sum_tax: lump_sum_tax, lump_sum_received: lump_sum_received) }
    let(:lump_sum_tax) { double }
    let(:lump_sum_received) { double }

    it 'returns the calculated estimate' do
      expect(IncomeTaxCalculator).to receive(:new).with(lump_sum: chunk.to_f, income: income.to_f) { calculator }

      expect(estimate.pot).to eq(pot)
      expect(estimate.pot_remaining).to eq(pot - chunk)
      expect(estimate.chunk).to eq(chunk)
      expect(estimate.chunk_tax).to eq(lump_sum_tax)
      expect(estimate.chunk_remaining).to eq(lump_sum_received)
    end
  end
end
