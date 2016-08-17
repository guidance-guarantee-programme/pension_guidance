class HomeController < ApplicationController
  layout 'full_width'

  def show
    @show_footer = true
    expires_in Rails.application.config.cache_max_age, public: true
  end

  def show_experiment
    @show_footer = false
    render template: 'home/experiment', layout: 'experiments/home'
  end

  def footer?
    @show_footer
  end
end
