RSpec.describe 'Calculator routing', type: :routing do
  it 'routes /adjustable-income/estimate to calculators/adjustable_income#show' do
    expect(get('/adjustable-income/estimate'))
      .to route_to(controller: 'calculators/adjustable_income', action: 'show')
  end

  it 'routes /guaranteed-income/estimate to calculators/guaranteed_income#show' do
    expect(get('/guaranteed-income/estimate'))
      .to route_to(controller: 'calculators/guaranteed_income', action: 'show')
  end

  it 'routes /leave-pot-untouched/estimate to calculators/leave_pot_untouched#show' do
    expect(get('/leave-pot-untouched/estimate'))
      .to route_to(controller: 'calculators/leave_pot_untouched', action: 'show')
  end

  it 'routes /take-cash-in-chunks/estimate to calculators/take_cash_in_chunks#show' do
    expect(get('/take-cash-in-chunks/estimate'))
      .to route_to(controller: 'calculators/take_cash_in_chunks', action: 'show')
  end

  it 'routes /take-whole-pot/estimate to calculators/take_whole_pot#show' do
    expect(get('/take-whole-pot/estimate'))
      .to route_to(controller: 'calculators/take_whole_pot', action: 'show')
  end
end
