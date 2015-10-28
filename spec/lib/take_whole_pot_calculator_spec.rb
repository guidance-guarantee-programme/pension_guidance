RSpec.describe TakeWholePotCalculator do
  describe '.personal_allowance_for' do
    let(:income) { 0 }

    subject(:personal_allowance) { described_class.personal_allowance_for(income) }

    context 'when £100,000 and below total income' do
      let(:income) { 100_000 }

      it { is_expected.to eq(10_600) }
    end

    context 'when between £100,000 and £121,200 total income' do
      let(:income) { 110_000 }

      it { is_expected.to eq(5_600) }
    end

    context 'when £121,200 and above total income' do
      let(:income) { 122_000 }

      it { is_expected.to eq(0) }
    end
  end

  describe '.marginal_tax_for_pot_with_income' do
    let(:pot) { 0 }
    let(:income) { 0 }

    subject(:tax) { described_class.marginal_tax_for_pot_with_income(pot, income) }

    context 'when income is 0' do
      describe 'and taxable portion of pot is within the personal allowance' do
        let(:pot) { 10_000 }

        it do
          is_expected.to eq(
            basic: 0,
            higher: 0,
            additional: 0
          )
        end
      end

      describe 'and taxable portion of pot is within the basic rate band' do
        let(:pot) { 20_000 }

        it do
          is_expected.to eq(
            basic: 880,
            higher: 0,
            additional: 0
          )
        end
      end

      describe 'and taxable portion of pot is within the higher rate band' do
        let(:pot) { 60_000 }

        it do
          is_expected.to eq(
            basic: 6357,
            higher: 1046,
            additional: 0
          )
        end
      end

      describe 'and taxable portion of pot is within the additional rate band' do
        let(:pot) { 220_000 }

        it do
          is_expected.to eq(
            basic: 6357,
            higher: 47_286,
            additional: 6750
          )
        end
      end
    end

    context 'when income is within the basic rate band' do
      let(:income) { 15_000 }

      describe 'and taxable portion of pot is within the basic rate band' do
        let(:pot) { 20_000 }

        it do
          is_expected.to eq(
            basic: 3000,
            higher: 0,
            additional: 0
          )
        end
      end

      describe 'and taxable portion of pot is within the higher rate band' do
        let(:pot) { 40_000 }

        it do
          is_expected.to eq(
            basic: 5477,
            higher: 1046,
            additional: 0
          )
        end
      end

      describe 'and taxable portion of pot is within the additional rate band' do
        let(:pot) { 200_000 }

        it do
          is_expected.to eq(
            basic: 3357,
            higher: 47_286,
            additional: 6750
          )
        end
      end
    end

    context 'when income is within the higher rate band' do
      let(:income) { 45_000 }

      describe 'and taxable portion of pot is within the higher rate band' do
        let(:pot) { 20_000 }

        it do
          is_expected.to eq(
            basic: 0,
            higher: 6000,
            additional: 0
          )
        end
      end

      describe 'and taxable portion of pot is within the additional rate band' do
        let(:income) { 160_000 }
        let(:pot) { 20_000 }

        it do
          is_expected.to eq(
            basic: 0,
            higher: 0,
            additional: 6750
          )
        end
      end
    end

    context 'when income is within the additional rate band' do
      let(:pot) { 20_000 }
      let(:income) { 150_000 }

      it do
        is_expected.to eq(
          basic: 0,
          higher: 0,
          additional: 6750
        )
      end
    end
  end

  scenarios =
    [{
      income:       0,
      pot:          10_000,
      pot_tax:      0,
      pot_received: 10_000
    }, {
      income:       10_000,
      pot:          20_000,
      pot_tax:      2_880,
      pot_received: 17_120
    }, {
      income:       30_000,
      pot:          50_000,
      pot_tax:      12_523,
      pot_received: 37_477
    }, {
      income:       0,
      pot:          160_000,
      pot_tax:      41_403,
      pot_received: 118_597
    }, {
      income:       70_000,
      pot:          250_000,
      pot_tax:      80_375,
      pot_received: 169_625
    }]

  scenarios.each do |scenario|
    context "with a pot of £#{scenario[:pot]} and an income of £#{scenario[:income]}" do
      subject(:calculator) { TakeWholePotCalculator.new(scenario[:pot], scenario[:income]) }

      specify { expect(calculator.pot_received).to eq(scenario[:pot_received]) }
      specify { expect(calculator.pot_tax).to eq(scenario[:pot_tax]) }
    end
  end
end
