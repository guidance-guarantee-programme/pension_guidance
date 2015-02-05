class GuidesController < ApplicationController
  layout 'guides'

  decorates_assigned :guide, with: GuideDecorator

  def show
    @guide = guide_repository.find(params[:id])
    @journey = Journey.new(*GuideDecorator.decorate_collection(journey_steps))
    @related_guides = @journey.include?(@guide) ? journey_related_guides : related_guides

    expires_in Rails.application.config.cache_max_age, public: true
  end

  private

  def guide_repository
    @guide_repository ||= GuideRepository.new
  end

  def related_guides
    @related_guides ||=
      GuideDecorator.decorate_collection(
        guide_repository.find_all(
          'pension-pot-options',
          '6-things-you-need-to-know',
          'pension-types',
          'tax'
        )
      )
  end

  def journey_related_guides
    @journey_related_guides ||=
      GuideDecorator.decorate_collection(
        guide_repository.find_all('benefits', 'scams')
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
