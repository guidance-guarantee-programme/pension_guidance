class GuidesController < ApplicationController
  layout 'guides'

  def show
    guide = guide_repository.find(params[:id])

    @related_guides = decorate(related_guides_for(guide))
    @journey = decorate(journey_steps)
    @guide = decorate(guide)

    expires_in Rails.application.config.cache_max_age, public: true
  end

  private

  def guide_repository
    @guide_repository ||= GuideRepository.new
  end

  def decorate(guide_or_collection)
    if guide_or_collection.is_a?(Enumerable)
      guide_or_collection.map { |guide| GuideDecorator.for(guide) }
    else
      GuideDecorator.for(guide_or_collection)
    end
  end

  def related_guides_for(guide)
    journey_steps.include?(guide) ? journey_related_guides : non_journey_related_guides
  end

  def non_journey_related_guides
    @related_guides ||=
      guide_repository.find_all(
        'pension-pot-options',
        '6-things-you-need-to-know',
        'pension-types',
        'tax'
      )
  end

  def journey_related_guides
    @journey_related_guides ||=
      guide_repository.find_all(
        'benefits',
        'scams'
      )
  end

  def journey_steps
    @journey_steps ||=
      guide_repository.find_all(
        'pension-pot-value',
        'pension-pot-options',
        'making-money-last',
        'work-out-income',
        'tax',
        'shop-around'
      )
  end
end
