RSpec.describe 'Category routing', type: :routing do
  it 'routes /browse/tax-and-getting-advice to categories#show' do
    expect(get('/browse/tax-and-getting-advice'))
      .to route_to(controller: 'categories', action: 'show', id: 'tax-and-getting-advice')
  end
end
