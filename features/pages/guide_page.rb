module Pages
  class Guide < SitePrism::Page
    set_url('/{slug}')
    set_url_matcher(/\/(\w|-)+$/)

    element :journey_nav_current_step, '.t-journey-nav__current-step'
    element :pager_item_next, '.t-pager__item-next'
    element :pager_item_previous, '.t-pager__item-previous'
    element :primary_heading, 'h1'

    elements :journey_nav_steps, '.t-journey-nav-step'
    elements :link_promo_items, '.t-link-promo__item'
  end
end
