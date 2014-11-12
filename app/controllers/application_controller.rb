class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'govuk_template'
end
