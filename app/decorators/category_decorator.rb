class CategoryDecorator
  delegate :id, :title, :description, :label, :slug, to: :category

  def initialize(category)
    @category = category
  end

  def label
    title
  end

  def url
    "/browse/#{slug}"
  end

  private

  attr_reader :category
end
