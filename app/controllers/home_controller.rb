class HomeController < ApplicationController
  layout 'full_width'

  def show
    expires_in Rails.application.config.cache_max_age, public: true
  end
end
