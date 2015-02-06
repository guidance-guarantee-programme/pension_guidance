class HTMLGuideDecorator < GuideDecorator
  def title
    @title ||= content_document.css('h1').first.try(:text)
  end

  def content
    @content ||= guide_content.html_safe
  end

  private

  def guide_content
    object.content
  end

  def content_document
    @content_document ||= Nokogiri::HTML(guide_content)
  end
end
