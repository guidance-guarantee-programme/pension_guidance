class CategoryNavigation
  extend Forwardable

  def initialize(category, guides, locale = I18n.locale)
    self.category = category
    self.guides = guides
    self.locale = locale
  end

  attr_accessor :category, :guides, :locale
  private :category=, :guides=, :locale=

  def_delegators :category, :title, :description
end
