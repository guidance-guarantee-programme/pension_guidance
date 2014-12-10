class ArticleRepository
  ArticleNotFound = Class.new(StandardError)

  REPOSITORY = Rails.root.join('content')

  def initialize(repository = REPOSITORY)
    @repository = Pathname.new(repository)
  end

  def find(id)
    file = path(id)

    fail ArticleNotFound unless file.exist?

    Article.new(id, File.read(file))
  end

  def self.find(id)
    (new).find(id)
  end

  private

  attr_reader :repository

  def path(id)
    repository.join("#{id.tr('-', '_')}.md")
  end
end
