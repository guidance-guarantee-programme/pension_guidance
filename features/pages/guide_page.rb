require_relative 'page'

module Pages
  class Guide < Page
    set_url('/{slug}')
    set_url_matcher(%r{\/(\w|-)+$})

    element :journey_nav_current_step, '.t-journey-nav__current-step'
    element :pager_item_next, '.t-pager__item-next'
    element :pager_item_previous, '.t-pager__item-previous'
    element :primary_heading, 'h1'

    elements :journey_nav_steps, '.t-journey-nav-step'
    elements :journey_subnav_steps, '.t-journey-subnav-step'
  end
end
