class CategoryNavigation
  extend Forwardable

  def initialize(category, guides)
    self.category = category
    self.guides = guides
  end

  attr_accessor :category, :guides
  private :category=, :guides=

  def_delegators :category, :title, :description
end
