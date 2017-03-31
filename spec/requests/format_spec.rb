RSpec.describe 'Accepted format', type: :request do
  context 'requesting a resource with no specified format' do
    it 'returns a 200 response status' do
      get '/en/pension-types'

      expect(response.status).to eq(200)
    end
  end

  context 'requesting a HTML formatted resource' do
    it 'returns a 200 response status' do
      get '/en/pension-types.html'

      expect(response.status).to eq(200)
    end
  end
end
