require_relative '../sections/footer_section'

module Pages
  class Page < SitePrism::Page
    element :heading, 'h1'
    elements :link_promo_items, '.t-link-promo__item'

    section :footer, Sections::Footer, '#footer'

    def check_hidden_checkbox(element, check)
      input = element.find('input[type=checkbox]', visible: false)
      input.trigger('click') if input['checked'] != check

      raise 'value did not change' if input['checked'] != check
    end

    def check_hidden_radio(element)
      input = element.find('input[type=radio]', visible: false)
      input.trigger('click')
    end
  end
end
