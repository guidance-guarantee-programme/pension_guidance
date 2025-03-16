RSpec.describe 'Caching', type: :request do
  I18n.available_locales.each do |locale|
    cacheable_content = {
      'locations home' => "/#{locale}/locations",
      'valid location search' => ["/#{locale}/locations", { params: { postcode: 'SW1A%202HQ' } }],
      'invalid location search' => ["/#{locale}/locations", { params: { postcode: 'london' } }],
      location: "/#{locale}/locations/london",
      category: "/#{locale}/browse/tax-and-getting-advice",
      home: "/#{locale}/browse/tax-and-getting-advice"
    }

    cacheable_content.each do |page, path|
      context "requesting a #{page} page in the #{locale} locale" do
        subject do
          case path
          when String
            get path
          else
            get path.first, **path.second
          end
        end

        specify 'the response may be cached for 10 seconds by default' do
          subject
          expect(response.headers['Cache-Control']).to eq('max-age=10, public')
        end

        context 'when the environment specifies a `CACHE_MAX_AGE` seconds value' do
          before do
            allow(Rails.application.config).to receive(:cache_max_age).and_return(1.hour.to_s)
          end

          specify 'the response may be cached for `CACHE_MAX_AGE`' do
            subject
            expect(response.headers['Cache-Control']).to eq('max-age=3600, public')
          end
        end
      end
    end
  end
end
