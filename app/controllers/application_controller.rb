class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: ENV['AUTH_USERNAME'], password: ENV['AUTH_PASSWORD'] if Rails.env.production?

  layout 'govuk_template'
end
