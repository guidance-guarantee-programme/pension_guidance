class GuidesController < ApplicationController
  layout 'guides'

  JOURNEY_GUIDE_IDS = %w(
    pension-pot-value
    pension-pot-options
    making-money-last
    work-out-income
    tax
    shop-around
  )

  NON_JOURNEY_RELATED_GUIDE_IDS = %w(
    pension-pot-options
    6-steps-you-need-to-take
    pension-types
    tax
  )

  JOURNEY_RELATED_GUIDE_IDS = %w(
    when-you-die
    benefits
    scams
  )

  def show
    guide = guide_repository.find(params[:id])

    @related_guides = decorate(related_guides_for(guide))
    @journey = decorate(journey_guides)
    @guide = decorate(guide)

    expires_in Rails.application.config.cache_max_age, public: true
  end

  private

  def guide_repository
    @guide_repository ||= GuideRepository.new
  end

  def decorate(guide_or_collection)
    if guide_or_collection.is_a?(Enumerable)
      guide_or_collection.map { |guide| GuideDecorator.cached_for(guide) }
    else
      GuideDecorator.cached_for(guide_or_collection)
    end
  end

  def related_guides_for(guide)
    journey_guide?(guide) ? journey_related_guides : non_journey_related_guides
  end

  def non_journey_related_guides
    @related_guides ||= guide_repository.find_all(*NON_JOURNEY_RELATED_GUIDE_IDS)
  end

  def journey_related_guides
    @journey_related_guides ||= guide_repository.find_all(*JOURNEY_RELATED_GUIDE_IDS)
  end

  def journey_guides
    @journey_guides ||= guide_repository.find_all(*JOURNEY_GUIDE_IDS)
  end

  def journey_guide?(guide)
    JOURNEY_GUIDE_IDS.include?(guide.id)
  end
end
