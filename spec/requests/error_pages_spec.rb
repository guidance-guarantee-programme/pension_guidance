RSpec.describe 'Error pages', type: :request do
  specify 'category not found' do
    get '/en/browse/non-existent-category'

    expect(response).to be_not_found
    expect(response).to render_template(:not_found)
  end

  specify 'guide not found' do
    get '/en/non-existent-guide'

    expect(response).to be_not_found
    expect(response).to render_template(:not_found)
  end
end
