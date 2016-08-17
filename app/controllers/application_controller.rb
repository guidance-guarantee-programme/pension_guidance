class ApplicationController < ActionController::Base
  include Breadcrumbs

  protect_from_forgery

  helper_method :homepage_experiment_id
  helper_method :footer?

  if ENV['AUTH_USERNAME'] && ENV['AUTH_PASSWORD']
    http_basic_authenticate_with name: ENV['AUTH_USERNAME'], password: ENV['AUTH_PASSWORD']
  end

  def footer?
    true
  end

  private

  def homepage_experiment_id
    ENV['HOMEPAGE_EXPERIMENT_ID']
  end
end
