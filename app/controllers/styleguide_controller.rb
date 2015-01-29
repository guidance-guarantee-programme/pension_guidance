class StyleguideController < ApplicationController
  layout 'styleguide/default'

  def pages_homepage
    render layout: 'styleguide/full_width', template: 'styleguide/pages/homepage'
  end

  def pages_article
    render layout: 'styleguide/full_width', template: 'styleguide/pages/guide'
  end
end
