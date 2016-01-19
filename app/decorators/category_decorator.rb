class CategoryDecorator < Draper::Decorator
  delegate :id, :title, :description, :label

  def label
    title
  end

  def url
    "/browse/#{object.slug}"
  end
end
