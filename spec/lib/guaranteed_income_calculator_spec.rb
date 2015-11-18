RSpec.describe GuaranteedIncomeCalculator do
  let(:pot) { 133_333 }
  let(:age) { 56 }

  subject(:calculator) { described_class.new(pot, age) }

  specify { expect(calculator.tax_free_lump_sum).to eq(33_333.25) }

  describe '#single_annuity' do
    scenarios =
      {
        55 => 4_614,
        60 => 5_160,
        65 => 5_828,
        70 => 6_670,
        75 => 7_875
      }

    scenarios.each do |age, income|
      describe "at age #{age}" do
        subject { described_class.new(pot, age).single_annuity.round }

        it { is_expected.to eq(income) }
      end
    end
  end
end
