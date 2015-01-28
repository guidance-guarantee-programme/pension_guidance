module Pages
  class Guide < SitePrism::Page
    set_url '/guides{/id}'
    set_url_matcher %r{/guides/\w+}
  end
end
