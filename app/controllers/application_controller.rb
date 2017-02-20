class ApplicationController < ActionController::Base
  include Breadcrumbs

  protect_from_forgery with: :exception
  before_action :set_locale

  helper_method :footer?

  if ENV['AUTH_USERNAME'] && ENV['AUTH_PASSWORD']
    http_basic_authenticate_with name: ENV['AUTH_USERNAME'], password: ENV['AUTH_PASSWORD']
  end

  def footer?
    true
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
