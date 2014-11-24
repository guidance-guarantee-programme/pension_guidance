class Article
  class ArticleNotFound < StandardError; end

  attr_accessor :id, :title, :content

  def initialize(id)
    @id = id
  end

  def title
    header = govspeak.headers.find { |header| header.level == 1 }
    @title ||= if header.present? then header.text else '' end
  end

  def content
    @content ||= html
  end

  def ==(other)
    self.id == other.id
  end

  def self.find(id)
    article = self.new(id)

    article.instance_eval do
      raise ArticleNotFound unless viewpath.exist?
    end

    article
  end

  private

  def view
    "#{@id.tr('-', '_')}.md"
  end

  def viewpath
    Rails.root.join('app', 'views', 'articles', view)
  end

  def govspeak
    raise ArticleNotFound unless viewpath.exist?

    source = File.read(viewpath)
    Govspeak::Document.new(source)
  end

  def html
    govspeak.to_sanitized_html.html_safe
  end
end
