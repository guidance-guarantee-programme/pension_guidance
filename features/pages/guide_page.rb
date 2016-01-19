require_relative 'page'

module Pages
  class Guide < Page
    set_url('/{slug}')
    set_url_matcher(%r{\/(\w|-)+$})

    element :primary_heading, 'h1'
    elements :option_links, '.t-option'
  end
end
