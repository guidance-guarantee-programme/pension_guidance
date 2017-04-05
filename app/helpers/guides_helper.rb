module GuidesHelper
  def book_an_appointment_link?
    !@guide.related_to_appointments?
  end

  def previous_guide
    return @previous_guide if defined?(@previous_guide)

    previous_sibling = current_node.previous_sibling
    @previous_guide = previous_sibling && GuideDecorator.cached_for(GuideRepository.new.find(previous_sibling.name))
  end

  def next_guide
    return @next_guide if defined?(@next_guide)

    next_sibling = current_node.next_sibling
    @next_guide = next_sibling && GuideDecorator.cached_for(GuideRepository.new.find(next_sibling.name))
  end

  private

  def current_node
    @current_node ||= Taxonomy.instance.tree.detect { |node| node.name == @guide.id }
  end
end
