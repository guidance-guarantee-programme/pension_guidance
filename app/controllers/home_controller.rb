class HomeController < ApplicationController
  layout 'home'

  def show
    expires_in Rails.application.config.cache_max_age, public: true
  end

  def footer?
    true
  end

  def content_lang_matches_locale?
    true
  end
end
