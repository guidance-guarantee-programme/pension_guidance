class GuideDecorator < Draper::Decorator
  delegate :slug, :description

  def title
    @title ||= govspeak.headers.find { |header| header.level == 1 }.try(:text)
  end

  def content
    @content ||= govspeak.to_sanitized_html.html_safe
  end

  private

  def govspeak
    @govspeak ||= Govspeak::Document.new(object.source)
  end
end
