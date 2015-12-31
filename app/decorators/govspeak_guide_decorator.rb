class GovspeakGuideDecorator < GuideDecorator
  def content
    @content ||= content_document.to_html.html_safe
  end

  def headers(level = 1)
    content_document.headers.select { |header| header.level == level }.each_with_object({}) do |header, headers|
      headers[header.id] = header.text
    end
  end

  private

  def content_document
    @content_document ||= Govspeak::Document.new(object.content)
  end
end
