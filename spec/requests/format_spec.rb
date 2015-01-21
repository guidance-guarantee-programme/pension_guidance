require 'spec_helper'

RSpec.describe 'Accepted format', type: :request do
  context 'requesting a resource with no specified format' do
    it 'returns a 200 response status' do
      get '/articles/know-your-pension-type'

      expect(response.status).to eq(200)
    end
  end

  context 'requesting a HTML formatted resource' do
    it 'returns a 200 response status' do
      get '/articles/know-your-pension-type.html'

      expect(response.status).to eq(200)
    end
  end

  context 'requesting a ZIP formatted resource' do
    it 'returns a 404 response status' do
      get '/articles/know-your-pension-type.zip'

      expect(response.status).to eq(404)
    end
  end
end
