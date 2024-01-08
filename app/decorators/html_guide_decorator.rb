# rubocop:disable Rails/OutputSafety
class HTMLGuideDecorator < GuideDecorator
  def content
    @content ||= Kramdown::Document.new(guide.content, input: 'html').to_html.html_safe
  end
end
# rubocop:enable Rails/OutputSafety
