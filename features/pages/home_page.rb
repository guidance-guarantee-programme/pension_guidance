require_relative 'page'

module Pages
  class Home < Page
    set_url '/'

    elements :links, '.t-article-links'
  end
end
