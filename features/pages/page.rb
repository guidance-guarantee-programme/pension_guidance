require_relative '../sections/search_section'

module Pages
  class Page < SitePrism::Page
    element :heading, 'h1'
    elements :link_promo_items, '.t-link-promo__item'

    section :search, Sections::Search, '.t-search'
  end
end
