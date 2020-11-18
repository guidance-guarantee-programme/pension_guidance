class GuidesController < ApplicationController
  layout :guide_layout

  before_action :find_guide
  before_action :set_breadcrumbs
  after_action  :set_frame_options, if: -> { @guide.embeddable? }

  UNTRANSLATED_GUIDE_SLUGS = %w(
    book-face-to-face
    book-phone
  ).freeze

  def show
    expires_in Rails.application.config.cache_max_age, public: true
  end

  private

  def guide_layout
    if @guide.embeddable?
      'full_width_widget'
    else
      'guides'
    end
  end

  def set_frame_options
    response.headers.except! 'X-Frame-Options'
  end

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

  def alternate_url(new_locale, options = {})
    new_params = params.permit(:id, :ici, :icn, :locale)
    new_params.merge!(options)
    new_params[:locale] = new_locale

    url_for(new_params)
  end
end
