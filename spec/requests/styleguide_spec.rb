RSpec.describe 'Styleguide', type: :request do
  describe 'styleguide pages' do
    routes = Rails.application.routes.routes.map do |route|
      path = route.path.spec.to_s
      path.sub(/\(.:format\)/, '') if path =~ /styleguide/ && path !~ /:action/
    end.compact

    routes.each do |route|
      it "gives a 200 for each styleguide page #{route}" do
        get route
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'styleguide component pages' do
    components = Dir[Rails.root.join('app', 'views', 'styleguide', '*.html.erb')].map do |f|
      File.basename(f, '.html.erb')
    end

    components.reject! { |f| f =~ /index$/ }
    components.each do |component|
      route = "/styleguide/#{component}"

      it "gives a 200 for each styleguide component page #{route}" do
        get route
        expect(response.status).to eq(200)
      end
    end
  end
end
