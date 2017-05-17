class GuidesController < ApplicationController
  layout 'guides'

  before_action :find_guide
  before_action :set_breadcrumbs

  UNTRANSLATED_GUIDE_SLUGS = %w(
    appointments
    book-face-to-face
    book-phone
    pension-type-tool
    pension-type-tool/defined-contribution
    pension-type-tool/might-defined-contribution
    pension-type-tool/most-cases-defined-benefit
    pension-type-tool/most-cases-defined-contribution
    pension-type-tool/question-1
    pension-type-tool/question-2
    pension-type-tool/question-3
    pension-type-tool/question-4
  ).freeze

  def show
    expires_in Rails.application.config.cache_max_age, public: true
  end

  private

  def id
    params[:id]
  end

  def find_guide
    @guide = GuideDecorator.cached_for(GuideRepository.new.find(id))
  end

  def set_breadcrumbs
    breadcrumb(Breadcrumb.book_an_appointment) if @guide.related_to_booking?
    breadcrumb(Breadcrumb.pension_options) if @guide.option?
  end

  def content_lang_matches_locale?
    UNTRANSLATED_GUIDE_SLUGS.exclude?(params[:id])
  end
end
