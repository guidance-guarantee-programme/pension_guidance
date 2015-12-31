class HTMLGuideDecorator < GuideDecorator
  def content
    @content ||= guide_content.html_safe
  end

  def headers(level = 1)
    content_document.css("h#{level}").each_with_object({}) do |header, headers|
      headers[header[:id]] = header.text
    end
  end

  private

  def guide_content
    Kramdown::Document.new(object.content, input: 'html').to_html
  end

  def content_document
    @content_document ||= Nokogiri::HTML(guide_content)
  end
end
