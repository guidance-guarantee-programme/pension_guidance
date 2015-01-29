RSpec.describe 'Guide routing', type: :routing do
  it 'routes /tax-you-pay-on-your-pension to guides#show' do
    expect(get('/tax-you-pay-on-your-pension'))
      .to route_to(controller: 'guides', action: 'show', id: 'tax-you-pay-on-your-pension')
  end
end
