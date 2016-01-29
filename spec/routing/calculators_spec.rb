RSpec.describe 'Calculator routing', type: :routing do
  it 'routes /take-whole-pot/estimate to calculators/take_whole_pot#show' do
    expect(get('/take-whole-pot/estimate'))
      .to route_to(controller: 'calculators/take_whole_pot', action: 'show')
  end
end
