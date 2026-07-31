RSpec.describe 'Cloudflare 2FA identification', type: :request do
  it 'returns the identifier txt' do
    get '/.well-known/cf-2fa-verify.txt'

    expect(response.body).to eq('jlr2ehvq75gph87j')
  end
end
