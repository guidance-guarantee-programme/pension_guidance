class ApplicationController < ActionController::Base
  include Breadcrumbs
  include LogrageFilterer

  protect_from_forgery with: :exception

  before_action :set_locale

  helper_method :footer?, :alternate_locales, :default_locale?, :content_lang_matches_locale?

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

  # Override in controllers to account for their
  # particular permitted parameters.
  def alternate_url(new_locale, options = {})
    options[:locale] = new_locale

    url_for(options)
  end
  helper_method :alternate_url

  def default_url_options(options = {})
    options.reverse_merge(locale: I18n.locale)
  end

  def default_locale?
    I18n.locale == I18n.default_locale
  end

  def content_lang_matches_locale?
    # By default, anything not in the default locale
    # is assumed to not be translated.
    default_locale?
  end
end
