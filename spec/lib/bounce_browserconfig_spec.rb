RSpec.describe BounceBrowserconfig, type: :request do
  let(:main_app) { ->(_env) { [200, {}, []] } }
  let(:app) { described_class.new(main_app) }

  context 'GET /' do
    it 'gives a 200' do
      get '/'

      expect(response.status).to eq(200)
    end
  end

  context 'GET /browserconfig.xml' do
    it 'gives a 404' do
      get '/browserconfig.xml'

      expect(response.status).to eq(404)
    end
  end
end
