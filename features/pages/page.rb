require_relative '../sections/footer_section'

module Pages
  class Page < SitePrism::Page
    element :accept_cookies, '.ccc-accept-button'
    element :heading, 'h1'
    elements :link_promo_items, '.t-link-promo__item'

    section :footer, Sections::Footer, '#footer'

    def accept_cookies!
      return unless loaded?

      wait_until_accept_cookies_visible
      accept_cookies.click
    end
  end
end
