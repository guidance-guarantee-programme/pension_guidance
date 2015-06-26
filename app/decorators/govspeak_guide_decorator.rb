class GovspeakGuideDecorator < GuideDecorator
  def title
    @title ||= content_document.headers.find { |header| header.level == 1 }.try(:text)
  end

  def content
    @content ||= content_document.to_html.html_safe
  end

  private

  def content_document
    @content_document ||= Govspeak::Document.new(object.content)
  end
end
