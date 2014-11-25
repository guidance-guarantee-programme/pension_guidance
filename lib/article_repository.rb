class ArticleRepository

  class ArticleNotFound < StandardError; end

  def self.find(id)
    repository = self.new

    source = repository.instance_eval do
      file = path(id)

      raise ArticleNotFound unless file.exist?

      File.read file
    end

    Article.new(id, source)
  end

  private

  def path(id)
    Rails.root.join('content', "#{id.tr('-', '_')}.md")
  end

end
