module Breadcrumbs
  extend ActiveSupport::Concern

  included do
    helper_method :breadcrumb
    before_action :clear_breadcrumbs
  end

  private

  attr_reader :breadcrumbs

  def breadcrumb(breadcrumb)
    @breadcrumbs << breadcrumb
  end

  def clear_breadcrumbs
    @breadcrumbs = []
  end
end
