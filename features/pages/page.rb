require_relative '../sections/search_section'

module Pages
  class Page < SitePrism::Page
    section :search, Sections::Search, '.t-search'
  end
end
