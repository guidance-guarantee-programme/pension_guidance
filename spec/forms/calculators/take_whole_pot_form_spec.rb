RSpec.describe Calculators::TakeWholePotForm do
  it { is_expected.to validate_presence_of(:pot) }
  it { is_expected.to validate_presence_of(:income) }
  it { is_expected.to validate_numericality_of(:pot).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:income).is_greater_than_or_equal_to(0) }

  describe 'type coercion' do
    subject(:calculator) do
      described_class.new(
        pot: '100,000',
        income: '10,000'
      )
    end

    specify { expect(calculator.pot).to eq(100_000.00) }
    specify { expect(calculator.income).to eq(10_000.00) }
  end

  describe '#result' do
    let(:pot) { 100_000 }
    let(:income) { 10_000 }
    let(:params) do
      {
        pot: pot,
        income: income
      }
    end

    def calculate_estimate
      described_class.new(params).estimate
    end

    subject(:estimate) { calculate_estimate }

    context 'with invalid input' do
      let(:pot) { 'invalid' }

      it { is_expected.to be_nil }
    end

    context 'with valid input' do
      it { is_expected.to be_a(IncomeTaxCalculator) }

      it 'instantiates the calculator' do
        expect(IncomeTaxCalculator).to receive(:new).with(lump_sum: pot, income: income)
        calculate_estimate
      end
    end
  end
end
