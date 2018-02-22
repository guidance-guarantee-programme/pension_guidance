require_relative 'page'

module Pages
  class LocationSearch < Page
    set_url '/{locale}/book-face-to-face'

    element :postcode, '.t-postcode'
    element :submit, '.t-submit'
  end
end
