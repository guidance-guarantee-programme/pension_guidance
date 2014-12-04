module Pages
  class Homepage < SitePrism::Page
    set_url '/'

    elements :links, '.t-article-links'
  end
end
