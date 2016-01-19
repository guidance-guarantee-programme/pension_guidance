require_relative 'page'

module Pages
  class Category < Page
    set_url('/browse/{slug}')
    set_url_matcher(%r{\/(\w|-)+$})

    elements :guide_links, '.t-guide-link'
  end
end
