RSpec.describe 'Category routing', type: :routing do
  it 'routes /en/browse/tax-and-getting-advice to categories#show' do
    expect(get('/en/browse/tax-and-getting-advice'))
      .to route_to(locale: 'en', controller: 'categories', action: 'show', id: 'tax-and-getting-advice')
  end
end
