class ApplicationController < ActionController::Base
  include Breadcrumbs
  include LogrageFilterer

  protect_from_forgery with: :exception

  before_action :set_locale

  helper_method :footer?, :alternate_locales

  if ENV['AUTH_USERNAME'] && ENV['AUTH_PASSWORD']
    http_basic_authenticate_with name: ENV['AUTH_USERNAME'], password: ENV['AUTH_PASSWORD']
  end

  unless Rails.env.development?
    rescue_from I18n::InvalidLocale, with: :not_found
  end

  def footer?
    true
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def alternate_locales
    I18n.available_locales - Array(I18n.locale)
  end

  def default_url_options(options = {})
    options.reverse_merge(locale: I18n.locale)
  end
end
