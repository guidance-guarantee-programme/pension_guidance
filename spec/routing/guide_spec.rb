RSpec.describe 'Guide routing', type: :routing do
  it 'routes /tax to guides#show' do
    expect(get('/tax'))
      .to route_to(controller: 'guides', action: 'show', id: 'tax')
  end
end
