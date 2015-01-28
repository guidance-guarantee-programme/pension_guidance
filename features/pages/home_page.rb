module Pages
  class Home < SitePrism::Page
    set_url '/'

    elements :links, '.t-article-links'
  end
end
