class StyleguideController < ApplicationController
  layout 'styleguide/full_width'

  def pages_homepage
    render template: 'styleguide/pages/homepage'
  end

  def pages_guide
    render template: 'styleguide/pages/guide'
  end

  def pages_journey_index
    render template: 'styleguide/pages/journey_index'
  end

  def pages_journey_page
    render template: 'styleguide/pages/journey_page'
  end
end
