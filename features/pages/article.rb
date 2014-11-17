module Pages
  class Article < SitePrism::Page
    set_url "/articles{/id}"
    set_url_matcher /\/articles\/\w+/
  end
end
