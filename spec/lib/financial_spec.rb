RSpec.describe Financial do
  describe '.future_value' do
    subject { described_class.future_value(principal_amount, additional_amount, nominal_interest_rate, time) }

    let(:principal_amount) { 25_000 }
    let(:additional_amount) { 1800 }
    let(:nominal_interest_rate) { 0.03 }
    let(:time) { 5 }

    it { is_expected.to eq(38_538.2963155) }
  end
end
