RSpec.describe LeavePotUntouchedCalculator, '#pot' do
  let(:initial_pot) { 50_000 }
  let(:annual_saving) { 2_000 }
  let(:duration) { 5 }
  let(:net_growth_rate) { 3 }
  let(:pot_growth) do
    [
      53_560.00,
      57_226.80,
      61_003.60,
      64_893.71,
      68_900.52
    ]
  end

  subject(:pot) do
    LeavePotUntouchedCalculator.new(initial_pot, annual_saving, duration, net_growth_rate).pot
  end

  it 'calculates the pot size over the given time period' do
    expect(pot).to eq(pot_growth)
  end
end
