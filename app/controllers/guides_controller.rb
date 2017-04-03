class GuidesController < ApplicationController
  layout 'guides'

  before_action :find_guide
  before_action :set_breadcrumbs

  def show
    expires_in Rails.application.config.cache_max_age, public: true
  end

  private

  def id
    params[:id]
  end

  def find_guide
    @guide = GuideDecorator.cached_for(GuideRepository.new(I18n.locale).find(id))
  end

  def set_breadcrumbs
    breadcrumb(Breadcrumb.book_an_appointment(params[:locale])) if @guide.related_to_booking?
    breadcrumb(Breadcrumb.pension_options(params[:locale])) if @guide.option?
  end
end
