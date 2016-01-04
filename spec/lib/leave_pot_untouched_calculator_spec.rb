RSpec.describe LeavePotUntouchedCalculator, '#pot' do
  let(:initial_pot) { 50_000 }
  let(:monthly_saving) { 200 }
  let(:duration) { 5 }
  let(:net_growth_rate) { 3 }
  let(:pot_growth) do
    [
      53_972.00,
      58_063.16,
      62_277.05,
      66_617.36,
      71_087.88
    ]
  end

  subject(:pot) do
    LeavePotUntouchedCalculator.new(initial_pot, monthly_saving, duration, net_growth_rate).pot
  end

  it 'calculates the pot size over the given time period' do
    expect(pot).to eq(pot_growth)
  end
end
