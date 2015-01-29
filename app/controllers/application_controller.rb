class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  if ENV['AUTH_USERNAME'] && ENV['AUTH_PASSWORD']
    http_basic_authenticate_with name: ENV['AUTH_USERNAME'], password: ENV['AUTH_PASSWORD']
  end

  layout 'govuk_template'
end
