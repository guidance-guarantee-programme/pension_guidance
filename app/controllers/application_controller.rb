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

  def alternate_url(new_locale, options = {}) # rubocop:disable Metrics/MethodLength
    new_params = params.delete_if { |k| %w(utf8 authenticity_token).include?(k) }
    new_params = new_params.permit(:id, :ici, :icn, :locale)
    new_params.merge!(options)
    new_params[:locale] = new_locale

    url_for(new_params)
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
