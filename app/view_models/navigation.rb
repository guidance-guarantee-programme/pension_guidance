class Navigation
  Item = Struct.new(:id, :label, :url, :option)
  Topic = Struct.new(:id, :label, :url, :items)

  attr_accessor :taxonomy
  private :taxonomy=

  def initialize(taxonomy)
    self.taxonomy = taxonomy
  end

  def topics
    topics = parented.collect(&method(:find_topic))
    topics << more_topic unless more_topic.items.empty?
    topics
  end

  private

  def find_topic(node)
    category = CategoryDecorator.decorate(node.content)
    guides = find_guides(node.children).reject(&:empty?)

    Topic.new(category.id, category.label, category.url, guides)
  end

  def find_guides(nodes)
    [].tap do |guides|
      guides.push(*find_parented_guides(nodes))
      guides.push(find_orphan_guides(nodes))
    end
  end

  def find_orphan_guides(nodes)
    nodes.reject(&:has_children?).map(&:content).map(&GuideDecorator.method(:cached_for)).map(&method(:build_item))
  end

  def find_parented_guides(nodes)
    [].tap do |guides|
      nodes.select(&:has_children?).each do |parent|
        guides << parent.children.map(&:content).map(&GuideDecorator.method(:cached_for)).map(&method(:build_item))
      end
    end
  end

  def build_item(guide)
    Item.new(guide.id, guide.label, guide.url, guide.option?)
  end

  def more_category
    @more_category ||= CategoryDecorator.decorate(CategoryRepository.new.find('more'))
  end

  def more_topic
    @more_topic ||= Topic.new(more_category.id, more_category.label, more_category.url, [orphan_guides])
  end

  def orphans
    @orphans ||= taxonomy.children.reject(&:has_children?)
  end

  def parented
    @parented ||= taxonomy.children.select(&:has_children?)
  end

  def orphan_guides
    @orphan_guides ||= orphans.map(&:content).map(&GuideDecorator.method(:cached_for)).map(&method(:build_item))
  end
end
