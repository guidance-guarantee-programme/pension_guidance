class JourneyNavigation
  extend Forwardable

  Step = Class.new do
    extend Forwardable

    def_delegators :@guide, :slug, :url, :label, :concise_label

    attr_accessor :current, :steps

    def initialize(guide, current = false, steps = [])
      @guide = guide
      self.current = current
      self.steps = steps
    end

    def current?
      current
    end

    def steps?
      !steps.empty?
    end
  end

  attr_accessor :journey_tree, :current_step
  private :journey_tree=, :current_step=

  def initialize(journey_tree, current_step = nil)
    self.journey_tree = journey_tree
    self.current_step = current_step
  end

  def active?
    @active ||= root.any? do |node|
      !node.is_root? && node.name == current_step
    end
  end

  def overview
    @overview ||= step(root)
  end

  def steps
    @steps ||= root.children.collect { |node| step(node) }
  end

  def next_step
    return if journey_index + 1 >= journey_size

    step(journey_array[journey_index + 1])
  end

  def previous_step
    return if journey_index == 0

    step(journey_array[journey_index - 1])
  end

  private

  def_delegator :journey_tree, :root
  def_delegator GuideDecorator, :cached_for, :decorate

  def journey_array
    @journey_array ||= journey_tree.to_a
  end

  def journey_size
    @journey_size ||= journey_array.count
  end

  def journey_index
    @journey_index ||= journey_tree.find_index { |node| node.name == current_step }
  end

  def step(node)
    guide = decorate(node.content)
    current = node.any? { |n| n.name == current_step }
    children = node.children.collect { |n| step(n) }

    Step.new(guide, current, children)
  end
end
