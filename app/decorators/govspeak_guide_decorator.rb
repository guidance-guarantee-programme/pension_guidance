# rubocop:disable Rails/OutputSafety
class GovspeakGuideDecorator < GuideDecorator
  def content
    @content ||= Govspeak::Document.new(guide.content).to_html.html_safe
  end
end
