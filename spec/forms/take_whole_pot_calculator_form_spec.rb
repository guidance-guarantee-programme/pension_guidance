RSpec.describe TakeWholePotCalculatorForm do
  it { is_expected.to validate_presence_of(:pot) }
  it { should validate_numericality_of(:pot).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:income) }
  it { should validate_numericality_of(:pension) }
  it { should validate_inclusion_of(:pension_frequency).in_array(%w(weekly annually)) }

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
end
