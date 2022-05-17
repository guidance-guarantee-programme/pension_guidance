class GuideDecorator < SimpleDelegator
  delegate :concise_label, :description, to: :metadata

  include Rails.application.routes.url_helpers

  def url
    guide_path(slug, locale: guide.locale)
  end

  def ga_origin
    "top-#{slug.split('/').last}"
  end

  def title
    @title ||= headers.values.first
  end

  def label
    metadata.label.presence || title
  end

  def content
    raise 'GuideDecorator subclasses must implement content'
  end

  def headers(level = 1)
    content_document.css("h#{level}").each_with_object({}) do |header, headers|
      headers[header[:id]] = header.text
    end
  end

  delegate :canonical, to: :metadata

  def noindex?
    metadata.noindex == true
  end

  def self.for(guide)
    case guide.content_type
    when :govspeak then GovspeakGuideDecorator.new(guide)
    when :html then HTMLGuideDecorator.new(guide)
    end
  end

  def self.cached_for(guide)
    CachedGuideDecorator.new(self.for(guide), Rails.cache)
  end

  private

  def guide
    __getobj__
  end

  def content_document
    @content_document ||= Nokogiri::HTML(content)
  end
end
