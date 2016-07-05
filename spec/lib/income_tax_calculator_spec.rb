RSpec.describe IncomeTaxCalculator do
  describe '.personal_allowance_for' do
    subject(:personal_allowance) { described_class.personal_allowance_for(income: income) }

    let(:income) { 0 }

    context 'when £100,000 and below total income' do
      let(:income) { 100_000 }

      it { is_expected.to eq(11_000) }
    end

    context 'when between £100,000 and £121,200 total income' do
      let(:income) { 110_000 }

      it { is_expected.to eq(6_000) }
    end

    context 'when £121,200 and above total income' do
      let(:income) { 122_000 }

      it { is_expected.to eq(0) }
    end
  end

  describe '.marginal_tax_for_lump_sum_with_income' do
    subject(:tax) { described_class.marginal_tax_for_lump_sum_with_income(lump_sum: lump_sum, income: income) }

    let(:lump_sum) { 0 }
    let(:income) { 0 }

    context 'when income is 0' do
      describe 'and taxable portion of lump sum is within the personal allowance' do
        let(:lump_sum) { 10_000 }

        it { is_expected.to eq(basic: 0, higher: 0, additional: 0) }
      end

      describe 'and taxable portion of lump sum is within the basic rate band' do
        let(:lump_sum) { 20_000 }

        it { is_expected.to eq(basic: 800, higher: 0, additional: 0) }
      end

      describe 'and taxable portion of lump sum is within the higher rate band' do
        let(:lump_sum) { 60_000 }

        it { is_expected.to eq(basic: 6400, higher: 800, additional: 0) }
      end

      describe 'and taxable portion of lump sum is within the additional rate band' do
        let(:lump_sum) { 220_000 }

        it { is_expected.to eq(basic: 6400, higher: 47_200, additional: 6750) }
      end
    end

    context 'when income is within the basic rate band' do
      let(:income) { 15_000 }

      describe 'and taxable portion of lump sum is within the basic rate band' do
        let(:lump_sum) { 20_000 }

        it { is_expected.to eq(basic: 3000, higher: 0, additional: 0) }
      end

      describe 'and taxable portion of lump sum is within the higher rate band' do
        let(:lump_sum) { 50_000 }

        it { is_expected.to eq(basic: 5600, higher: 3800, additional: 0) }
      end

      describe 'and taxable portion of lump sum is within the additional rate band' do
        let(:lump_sum) { 200_000 }

        it { is_expected.to eq(basic: 3400, higher: 47_200, additional: 6750) }
      end
    end

    context 'when income is within the higher rate band' do
      let(:income) { 50_000 }

      describe 'and taxable portion of lump sum is within the higher rate band' do
        let(:lump_sum) { 20_000 }

        it { is_expected.to eq(basic: 0, higher: 6000, additional: 0) }
      end

      describe 'and taxable portion of lump sum is within the additional rate band' do
        let(:income) { 160_000 }
        let(:lump_sum) { 20_000 }

        it { is_expected.to eq(basic: 0, higher: 0, additional: 6750) }
      end
    end

    context 'when income is within the additional rate band' do
      let(:lump_sum) { 20_000 }
      let(:income) { 150_000 }

      it { is_expected.to eq(basic: 0, higher: 0, additional: 6750) }
    end
  end

  [
    { income: 0, lump_sum: 10_000, lump_sum_tax: 0, lump_sum_received: 10_000 },
    { income: 10_000, lump_sum: 20_000, lump_sum_tax: 2_800, lump_sum_received: 17_200 },
    { income: 30_000, lump_sum: 50_000, lump_sum_tax: 12_400, lump_sum_received: 37_600 },
    { income: 0, lump_sum: 160_000, lump_sum_tax: 41_200, lump_sum_received: 118_800 },
    { income: 70_000, lump_sum: 250_000, lump_sum_tax: 80_375, lump_sum_received: 169_625 }
  ].each do |scenario|
    context "with a lump sum of £#{scenario[:lump_sum]} and an income of £#{scenario[:income]}" do
      subject(:calculator) { IncomeTaxCalculator.new(lump_sum: scenario[:lump_sum], income: scenario[:income]) }

      specify { expect(calculator.lump_sum_received).to eq(scenario[:lump_sum_received]) }
      specify { expect(calculator.lump_sum_tax).to eq(scenario[:lump_sum_tax]) }
    end
  end
end
