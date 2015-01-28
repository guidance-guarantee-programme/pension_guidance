require 'spec_helper'

RSpec.describe 'Compression', type: :request do
  ['deflate', 'gzip', 'deflate,gzip', 'gzip,deflate'].each do |compression_method|
    context "a visitor has a browser that supports '#{compression_method}' compression" do
      it 'compresses the content' do
        get '/guides/know-your-pension-type', {}, 'HTTP_ACCEPT_ENCODING' => compression_method

        expect(response.headers['Content-Encoding']).to be
      end
    end
  end

  context "a visitor's browser does not support compression" do
    it 'does not compresses the content' do
      get '/guides/know-your-pension-type'

      expect(response.headers['Content-Encoding']).to_not be
    end
  end
end
