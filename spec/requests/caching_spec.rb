require 'spec_helper'

RSpec.describe 'Caching', type: :request do
  context 'requesting a guide' do
    specify 'the response may be cached for 10 seconds by default' do
      get '/pension-types'

      expect(response.headers['Cache-Control']).to eq('max-age=10, public')
    end

    context 'when the environment specifies a `CACHE_MAX_AGE` seconds value' do
      before do
        ENV['CACHE_MAX_AGE'] = 1.hour.to_s
      end

      specify 'the response may be cached for `CACHE_MAX_AGE`' do
        get '/pension-types'

        expect(response.headers['Cache-Control']).to eq('max-age=3600, public')
      end
    end
  end
end
