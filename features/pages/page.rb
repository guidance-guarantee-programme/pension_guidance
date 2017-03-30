require_relative '../sections/footer_section'

module Pages
  class Page < SitePrism::Page
    element :heading, 'h1'
    elements :link_promo_items, '.t-link-promo__item'

    section :footer, Sections::Footer, '#footer'
  end
end
