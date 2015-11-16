RSpec.describe TakeWholePotCalculatorForm do
  it { is_expected.to validate_presence_of(:pot) }
  it { should validate_numericality_of(:pot).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:income) }
  it { should validate_numericality_of(:pension) }
  it { should validate_inclusion_of(:pension_frequency).in_array(%w(weekly annually)) }

  describe 'maximum state pension' do
    let(:pension) { 115 }
    let(:pension_frequency) { 'weekly' }

    subject(:form) do
      described_class.new(pension: pension, pension_frequency: pension_frequency)
    end

    before { form.validate }

    context 'below the limit' do
      specify { expect(form.errors).to_not have_key(:pension) }
    end

    context 'at the limit' do
      let(:pension) { 10_400 }
      let(:pension_frequency) { 'annually' }

      specify { expect(form.errors).to_not have_key(:pension) }
    end

    context 'above the limit' do
      let(:pension) { 201 }
      let(:pension_frequency) { 'weekly' }

      specify { expect(form.errors).to have_key(:pension) }
    end
  end

  describe 'type coercion' do
    subject(:calculator) do
      described_class.new(
        pot: '100,000',
        income: '10,000',
        pension: '1,000'
      )
    end

    specify { expect(calculator.pot).to eq(100_000.00) }
    specify { expect(calculator.income).to eq(10_000.00) }
    specify { expect(calculator.pension).to eq(1_000.00) }
  end

  describe '#result' do
    let(:pot) { 100_000 }
    let(:income) { 10_000 }
    let(:pension) { 100 }
    let(:pension_frequency) { 'weekly' }
    let(:params) do
      {
        pot: pot,
        income: income,
        pension: pension,
        pension_frequency: pension_frequency
      }
    end

    def calculate_result
      described_class.new(params).result
    end

    subject(:result) { calculate_result }

    it { is_expected.to be_a(TakeWholePotCalculator) }

    context 'with invalid input' do
      let(:pot) { 'invalid' }

      it { is_expected.to be_nil }
    end

    context 'when the pension is paid weekly' do
      let(:total_income) { 15_200 }

      it 'calculates the total income' do
        expect(TakeWholePotCalculator).to receive(:new).with(pot, total_income)
        calculate_result
      end
    end

    context 'when the pension is paid annually' do
      let(:pension_frequency) { 'annually' }
      let(:total_income) { 10_100 }

      it 'calculates the total income' do
        expect(TakeWholePotCalculator).to receive(:new).with(pot, total_income)
        calculate_result
      end
    end
  end
end
