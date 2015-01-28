module Pages
  class Article < SitePrism::Page
    set_url '/articles{/id}'
    set_url_matcher %r{/articles/\w+}
  end
end
