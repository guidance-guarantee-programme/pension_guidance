RSpec.describe 'Downloading a prebuilt summary document PDF', type: :request do
  %w[summary-50 summary-55].each do |variant|
    specify "Downloading the variant '#{variant}' without a file extension" do
      get "/#{variant}"

      expect(response).to redirect_to("/#{variant}.pdf")

      follow_redirect!

      expect(response.content_type).to eq('application/pdf')
    end
  end
end
