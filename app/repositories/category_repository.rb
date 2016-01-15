require 'yaml'

class CategoryRepository
  CategoryNotFound = Class.new(StandardError)

  attr_accessor :dir
  private :dir, :dir=

  def initialize(dir = Rails.root.join('categories'))
    self.dir = dir
  end

  def find(id)
    if (path = glob_dir(id.tr('-', '_')).try(:first))
      read_category(id, path)
    else
      fail CategoryNotFound
    end
  end

  private

  def read_category(id, path)
    source = YAML.load(File.read(path))

    Category.new(id, title: source['title'])
  end

  def glob_dir(file_pattern)
    Dir["#{dir}/**/#{file_pattern}.yml"]
  end
end
