class Article
  attr_accessor :id, :source, :title, :content

  def initialize(id, source = '')
    @id = id
    @source = source
  end

  def title
    @title ||= govspeak.headers.find { |header| header.level == 1 }.try(:text)
  end

  def content
    @content ||= html
  end

  def ==(other)
    self.id == other.id
  end

  private

  def govspeak
    Govspeak::Document.new(@source)
  end

  def html
    govspeak.to_sanitized_html.html_safe
  end
end
