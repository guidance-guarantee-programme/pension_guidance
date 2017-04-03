class Navigation
  Item = Struct.new(:id, :label, :url, :option, :parent)
  Topic = Struct.new(:id, :label, :url, :items)

  attr_accessor :taxonomy, :locale
  private :taxonomy=, :locale=

  def initialize(taxonomy, locale)
    self.taxonomy = taxonomy
    self.locale = locale
  end

  def topics
    topics = parented.collect(&method(:find_topic))
    topics << more_topic unless more_topic.items.empty?
    topics
  end

  private

  def find_topic(node)
    category = CategoryDecorator.new(node.content, locale)
    guides = find_guides(node.children).reject(&:empty?)

    Topic.new(category.id, category.label, category.url, guides)
  end

  def find_guides(nodes)
    [].tap do |guides|
      guides.concat(find_parented_guides(nodes))
      guides.push(find_orphan_guides(nodes))
    end
  end

  def find_orphan_guides(nodes)
    nodes.reject(&:has_children?).map(&:content).map(&GuideDecorator.method(:cached_for)).map(&method(:build_item))
  end

  def find_parented_guides(nodes)
    [].tap do |guides|
      nodes.select(&:has_children?).each do |parent|
        sub_category = []
        sub_category << build_item(GuideDecorator.cached_for(parent.content), true)

        parent.children.each do |child|
          sub_category << build_item(GuideDecorator.cached_for(child.content), false)
        end

        guides << sub_category
      end
    end
  end

  def build_item(guide, parent = false)
    Item.new(guide.id, guide.label, guide.url, guide.option?, parent)
  end

  def more_category
    @more_category ||= CategoryDecorator.new(CategoryRepository.new.find('more'), locale)
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
