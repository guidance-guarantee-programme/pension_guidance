class Article
  attr_reader :id, :source, :title, :content

  def initialize(id, source = '')
    @id = id
    @source = source
  end

  def title
    @title ||= govspeak.headers.find { |header| header.level == 1 }.try(:text)
  end

  def content
    @content ||= govspeak.to_sanitized_html.html_safe
  end

  private

  def govspeak
    @govspeak ||= Govspeak::Document.new(@source)
  end
end
