RSpec.describe LeavePotUntouchedCalculator, '#pot' do
  let(:initial_pot) { 50_000 }
  let(:annual_saving) { 2_000 }
  let(:duration) { 5 }
  let(:net_growth_rate) { 3 }
  let(:final_pot) { 68_900.52 }

  subject(:pot) do
    LeavePotUntouchedCalculator.new(initial_pot, annual_saving, duration, net_growth_rate).pot
  end

  it 'calculates the pot size at the end of the given time period' do
    expect(pot).to eq(final_pot)
  end
end
