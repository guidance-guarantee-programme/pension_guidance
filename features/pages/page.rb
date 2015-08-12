require_relative '../sections/search_section'

module Pages
  class Page < SitePrism::Page
    element :heading, 'h1'

    section :search, Sections::Search, '.t-search'
  end
end
