class StyleguideController < ApplicationController
  layout 'styleguide/full_width'

  def pages_homepage
    render template: 'styleguide/pages/homepage'
  end

  def pages_guide
    render template: 'styleguide/pages/guide'
  end

  def pages_appointments
    render template: 'styleguide/pages/appointments',
           layout: 'styleguide/pages'
  end

  def pages_book
    render template: 'styleguide/pages/book',
           layout: 'styleguide/pages'
  end

  def pages_locations_search
    render template: 'styleguide/pages/locations_search',
           layout: 'styleguide/pages'
  end

  def pages_locations_index
    render template: 'styleguide/pages/locations_index',
           layout: 'styleguide/pages'
  end

  def pages_locations_invalid
    render template: 'styleguide/pages/locations_invalid',
           layout: 'styleguide/pages'
  end

  def pages_locations_show
    render template: 'styleguide/pages/locations_show',
           layout: 'styleguide/pages'
  end

  def pages_locations_show_call_centre
    render template: 'styleguide/pages/locations_show_call_centre',
           layout: 'styleguide/pages'
  end

  def pages_search_results
    render template: 'styleguide/pages/search_results'
  end

  def pages_search_header
    render template: 'styleguide/pages/search_header',
           layout: 'styleguide/search_header'
  end
end
