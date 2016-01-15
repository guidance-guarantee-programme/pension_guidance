class CreateCategoryNavigation
  attr_accessor :category_id, :category_tree
  private :category_id=, :category_tree=

  def initialize(category_id, category_tree)
    self.category_id = category_id
    self.category_tree = category_tree
  end

  def call
    category = CategoryRepository.new.find(category_id)
    guides = nodes.map(&method(:extract)).map(&method(:decorate))

    CategoryNavigation.new(category, guides)
  end

  private

  def nodes
    case category_id
    when 'more'
      category_tree.children.reject(&:has_children?)
    else
      category_tree[category_id].children
    end
  end

  def extract(node)
    if node.has_children?
      [node.content, *node.children.map(&method(:extract))]
    else
      node.content
    end
  end

  def decorate(guide_or_guides)
    case guide_or_guides
    when Array
      guide_or_guides.map(&method(:decorate))
    else
      GuideDecorator.cached_for(guide_or_guides)
    end
  end
end
