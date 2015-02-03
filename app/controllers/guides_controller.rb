class GuidesController < ApplicationController
  layout 'guides'

  decorates_assigned :guide, with: GuideDecorator

  def show
    @guide = guide_repository.find(params[:id])
    @journey = Journey.new(*GuideDecorator.decorate_collection(journey_steps))

    expires_in Rails.application.config.cache_max_age, public: true
  end

  private

  def guide_repository
    @guide_repository ||= GuideRepository.new
  end

  def journey_steps
    @journey_steps ||= [
      guide_repository.find('pension-pot-value'),
      guide_repository.find('pension-pot-options'),
      guide_repository.find('making-money-last'),
      guide_repository.find('work-out-income'),
      guide_repository.find('tax'),
      guide_repository.find('shop-around')
    ]
  end
end
