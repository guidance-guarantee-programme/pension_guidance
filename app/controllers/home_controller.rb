class HomeController < ApplicationController
  layout 'home'

  def show
    @show_footer = false
    expires_in Rails.application.config.cache_max_age, public: true
  end

  def show_experiment
    @show_footer = true
    render template: 'home/experiment', layout: 'experiments/home'
  end

  def footer?
    @show_footer
  end
end
