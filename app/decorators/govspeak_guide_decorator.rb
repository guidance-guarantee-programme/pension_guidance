# rubocop:disable Rails/OutputSafety
class GovspeakGuideDecorator < GuideDecorator
  def content
    @content ||= Govspeak::Document.new(guide.content, sanitize: false).to_html.html_safe
  end
end
