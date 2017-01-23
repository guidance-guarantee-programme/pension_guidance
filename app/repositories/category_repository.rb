require 'yaml'

class CategoryRepository
  CategoryNotFound = Class.new(StandardError)

  attr_accessor :dir
  private :dir, :dir=

  def initialize(dir = Rails.root.join('categories'))
    self.dir = dir
  end

  def find(id)
    dirname = id.tr('-', '_')
    path = glob_dir(dirname)&.first || raise(CategoryNotFound)

    read_category(id, path)
  end

  private

  def read_category(id, path)
    source = YAML.safe_load(File.read(path))

    Category.new(id, title: source['title'], description: source['description'])
  end

  def glob_dir(file_pattern)
    Dir["#{dir}/**/#{file_pattern}.yml"]
  end
end
