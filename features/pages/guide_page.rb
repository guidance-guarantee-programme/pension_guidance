module Pages
  class Guide < SitePrism::Page
    set_url('/{slug}')
    set_url_matcher(/\/(\w|-)+$/)

    element :journey_nav_current_step, '.t-journey-nav-current-step'
    element :primary_heading, 'h1'

    elements :journey_nav_steps, '.t-journey-nav-step'
  end
end
