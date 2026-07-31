class HomeController < ApplicationController
  layout 'home'

  skip_before_action :set_locale, only: :cloudflare

  def cloudflare
    render plain: 'jlr2ehvq75gph87j', layout: false
  end

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
