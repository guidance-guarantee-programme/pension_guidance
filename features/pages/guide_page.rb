module Pages
  class Guide < SitePrism::Page
    set_url('/{id}')
    set_url_matcher(/\/(\w|-)+$/)

    element :primary_heading, 'h1'
  end
end
