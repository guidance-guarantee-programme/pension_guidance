RSpec.describe 'EYO redirects', type: :request do
  it 'redirects EN' do
    get '/en/explore-your-options'

    expect(response).to redirect_to('https://prd-pwtriage.moneyhelper.org.uk/en/pension-wise-triage/start')
  end

  it 'redirects CY' do
    get '/cy/explore-your-options/start'

    expect(response).to redirect_to('https://prd-pwtriage.moneyhelper.org.uk/cy/pension-wise-triage/start')
  end
end
