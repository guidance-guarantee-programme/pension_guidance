require_relative '../sections/pagination'
require_relative 'page'

module Pages
  class SearchResults < Page
    set_url '/search'

    elements :results, '.t-search-results__item'

    section :pagination, Sections::Pagination, '.t-pagination'
  end
end
