require 'spec_helper'

RSpec.describe 'Favicon', type: :request do
  context 'requesting a favicon.ico' do
    it 'returns a 404 response' do
      get '/favicon.ico'

      expect(response.status).to eq(404)
    end
  end
end
