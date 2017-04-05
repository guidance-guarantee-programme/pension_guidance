class CategoryDecorator
  delegate :id, :title, :description, :label, :slug, to: :category

  include Rails.application.routes.url_helpers

  def initialize(category, locale = I18n.locale)
    @category = category
    @locale = locale
  end

  def label
    title
  end

  def url
    category_path(slug, locale: locale)
  end

  private

  attr_reader :category, :locale
end
