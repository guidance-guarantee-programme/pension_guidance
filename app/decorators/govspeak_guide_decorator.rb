class GovspeakGuideDecorator < GuideDecorator
  def content
    @content ||= Govspeak::Document.new(object.content).to_html.html_safe
  end
end
