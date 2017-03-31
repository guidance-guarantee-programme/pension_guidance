RSpec.describe 'Favicon', type: :request do
  context 'requesting a favicon.ico' do
    before { get '/favicon.ico' }

    it 'returns a 301 response' do
      expect(response.status).to eq(301)
    end

    context 'and if I follow the redirect' do
      before { follow_redirect! }

      it 'returns a 404 response' do
        expect(response.status).to eq(404)
      end
    end
  end
end
