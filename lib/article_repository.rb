class ArticleRepository
  ArticleNotFound = Class.new(StandardError)

  def initialize(dir = Rails.root.join('content'))
    self.dir = dir
  end

  def find(id)
    path = path(id)

    if File.exist?(path)
      Article.new(id, File.read(path))
    else
      fail ArticleNotFound
    end
  end

  private

  attr_accessor :dir

  def path(id)
    param = "#{id.tr('-', '_')}.md"

    File.expand_path(param, dir)
  end
end
