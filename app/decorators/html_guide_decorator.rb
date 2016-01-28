class HTMLGuideDecorator < GuideDecorator
  def content
    @content ||= Kramdown::Document.new(object.content, input: 'html').to_html.html_safe
  end
end
