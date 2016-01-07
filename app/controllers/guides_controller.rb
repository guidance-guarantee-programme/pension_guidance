class GuidesController < ApplicationController
  layout 'guides'
  helper_method :journey_navigation
  before_action :set_breadcrumbs

  NON_JOURNEY_RELATED_GUIDE_IDS = %w(
    appointments
    pension-pot-options
    6-steps-you-need-to-take
    pension-types
    tax
  )

  JOURNEY_RELATED_GUIDE_IDS = %w(
    appointments
    when-you-die
    benefits
    care-costs
    scams
  )

  def show
    @guide = decorate(find(params[:id]))
    @related_guides = decorate(related_guides)

    expires_in Rails.application.config.cache_max_age, public: true
  end

  private

  def guide_repository
    @guide_repository ||= GuideRepository.new
  end

  def find(id)
    guide_repository.find(id)
  end

  def decorate(guide_or_collection)
    if guide_or_collection.is_a?(Enumerable)
      guide_or_collection.map { |guide| GuideDecorator.cached_for(guide) }
    else
      GuideDecorator.cached_for(guide_or_collection)
    end
  end

  def related_guides
    related_guides = if journey_navigation.active?
                       journey_related_guides
                     else
                       non_journey_related_guides
                     end

    if params[:id] == 'book'
      related_guides.reject! { |guide| guide.id == 'appointments' }
    end

    related_guides
  end

  def non_journey_related_guides
    @related_guides ||= guide_repository.find_all(*NON_JOURNEY_RELATED_GUIDE_IDS)
  end

  def journey_related_guides
    @journey_related_guides ||= guide_repository.find_all(*JOURNEY_RELATED_GUIDE_IDS)
  end

  def journey_navigation
    JourneyNavigation.new(JourneyTree.instance.tree, params[:id])
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_an_appointment if params[:id] == 'book'
  end
end
