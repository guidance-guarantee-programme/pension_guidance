class JourneyDecorator
  attr_accessor :guide, :index, :current, :journey_guides

  delegate :id, :label, :url, to: :guide

  def self.decorate(journey_guides, current_guide)
    journey_guides.map.with_index do |guide, index|
      new(guide,
          journey_guides: journey_guides,
          current: (guide.id == current_guide.id),
          index: index + 1)
    end
  end

  def initialize(guide, journey_guides: [], current: false, index: 0)
    @guide = GuideDecorator.cached_for(guide)
    @index = index
    @current = current
    @journey_guides = journey_guides
  end

  def ==(other)
    id == other.id
  end

  def current?
    @current
  end

  def first?
    index == 1
  end

  def last?
    index == journey_length
  end

  def journey_length
    journey_guides.count
  end

  def previous_step
    return unless journey_length > 0 && index > 1
    JourneyDecorator.new(journey_guides[index - 2], index: index - 1)
  end

  def next_step
    return unless journey_length > 0 && index < journey_length
    JourneyDecorator.new(journey_guides[index], index: index + 1)
  end

  def li_classes
    [].tap do |classes|
      classes << 'last-child' if last?
      classes << 'is-current' if current?
    end
  end

  def a_classes
    ['t-journey-nav-step'].tap do |classes|
      classes << 't-journey-nav__current-step' if current?
    end
  end

  def sub_nav
    return unless current? && id == 'pension-pot-options'

    File.read(
      Rails.root.join('app', 'views', 'components', '_pension_pot_sub_nav.html.erb')
    ).html_safe
  end
end
