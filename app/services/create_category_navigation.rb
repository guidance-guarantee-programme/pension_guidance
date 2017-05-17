class CreateCategoryNavigation
  attr_accessor :category_id, :category_tree, :locale
  private :category_id=, :category_tree=, :locale=

  def initialize(category_id, category_tree, locale = I18n.locale)
    self.category_id = category_id
    self.category_tree = category_tree
    self.locale = locale
  end

  def call
    category = CategoryRepository.new.find(category_id)
    guides = nodes.map { |n| extract(n) }.map { |n| decorate(n) }

    CategoryNavigation.new(category, guides, locale)
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
      [node.content, *node.children.map { |c| extract(c) }]
    else
      node.content
    end
  end

  def decorate(guide_or_guides)
    case guide_or_guides
    when Array
      guide_or_guides.map { |g| decorate(g) }
    else
      GuideDecorator.cached_for(guide_or_guides)
    end
  end
end
