cacheable_content = {
  'locations home' => '/locations',
  'valid location search' => ['/locations', params: { postcode: 'SW1A%202HQ' }],
  'invalid location search' => ['/locations', params: { postcode: 'london' }],
  location: '/locations/london',
  guide: '/pension-types',
  category: '/browse/tax-and-getting-advice',
  home: '/'
}

RSpec.describe 'Caching', type: :request do
  cacheable_content.each do |page, path|
    context "requesting a #{page} page" do
      specify 'the response may be cached for 10 seconds by default' do
        get(*path)

        expect(response.headers['Cache-Control']).to eq('max-age=10, public')
      end

      context 'when the environment specifies a `CACHE_MAX_AGE` seconds value' do
        before do
          allow(Rails.application.config).to receive(:cache_max_age).and_return(1.hour.to_s)
        end

        specify 'the response may be cached for `CACHE_MAX_AGE`' do
          get(*path)

          expect(response.headers['Cache-Control']).to eq('max-age=3600, public')
        end
      end
    end
  end
end
