RSpec.describe 'Pilot pension summary cookie', type: :request do
  before do
    allow(ENV).to receive(:[]).and_call_original
  end

  context 'when pilot summaries are enabled' do
    before do
      allow(ENV).to receive(:[]).with('PILOT_SUMMARIES').and_return('true')
    end

    it 'sets a cookie' do
      get '/en/explore-your-options'

      expect(cookies[:pilot_summaries]).to be_present
    end
  end

  context 'when pilot summaries are disabled' do
    before do
      allow(ENV).to receive(:[]).with('PILOT_SUMMARIES').and_return(nil)
    end

    it 'does not set a cookie' do
      get '/en/explore-your-options'

      expect(cookies[:pilot_summaries]).to be_nil
    end
  end
end
