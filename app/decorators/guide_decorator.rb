class GuideDecorator < Draper::Decorator
  delegate :id, :slug, :concise_label, :description,
           :option?, :related_to_appointments?, :related_to_booking?

  def url
    "/#{slug}"
  end

  def title
    @title ||= headers.values.first
  end

  def label
    object.label.blank? ? title : object.label
  end

  def content
    fail 'GuideDecorator subclasses must implement content'
  end

  def headers(level = 1)
    content_document.css("h#{level}").each_with_object({}) do |header, headers|
      headers[header[:id]] = header.text
    end
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

  def content_document
    @content_document ||= Nokogiri::HTML(content)
  end
end
