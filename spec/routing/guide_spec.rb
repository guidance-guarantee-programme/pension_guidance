RSpec.describe 'Guide routing', type: :routing do
  it 'routes /en/tax to guides#show' do
    expect(get('/en/tax'))
      .to route_to(locale: 'en', controller: 'guides', action: 'show', id: 'tax')
  end
end
