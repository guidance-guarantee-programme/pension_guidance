require_relative 'page'

module Pages
  class Locations < Page
    set_url '/{locale}/locations{?postcode}'

    element :invalid_postcode, '.t-invalid-postcode'
    element :empty_postcode_error, '.t-empty-postcode'

    sections :locations, '.t-location' do
      element :name, '.t-name'
      element :address, '.t-address'
      element :distance, '.t-distance'

      element :link_to, '.t-location-link'
    end
  end
end
