module Pages
  class Locations < SitePrism::Page
    set_url '/locations{?postcode}'

    sections :locations, '.t-location' do
      element :name, '.t-name'
      element :distance, '.t-distance'
    end
  end
end
