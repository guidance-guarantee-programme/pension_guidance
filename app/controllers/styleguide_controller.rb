class StyleguideController < ApplicationController
  layout 'styleguide/full_width'

  def pages_homepage
    render layout: 'styleguide/full_width', template: 'styleguide/pages/homepage'
  end

  def pages_guide
    render layout: 'styleguide/full_width', template: 'styleguide/pages/guide'
  end

  def pages_journey_index
    render layout: 'styleguide/full_width', template: 'styleguide/pages/journey_index'
  end

  def pages_journey_page
    render layout: 'styleguide/full_width', template: 'styleguide/pages/journey_page'
  end
end
