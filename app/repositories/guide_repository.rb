class GuideRepository
  GuideNotFound = Class.new(StandardError)

  attr_accessor :dir
  private :dir, :dir=

  def initialize(dir = Rails.root.join('content'))
    self.dir = dir
  end

  def find(id)
    if (path = glob_dir(id.tr('-', '_')).try(:first))
      Guide.new(id, path)
    else
      fail GuideNotFound
    end
  end

  def find_all(*ids)
    ids.each_with_object([]) do |id, results|
      results << find(id)
    end
  end

  def all
    glob_dir('*').each_with_object([]) do |path, result|
      id = File.basename(path, '.*')
      result << Guide.new(id, path)
    end
  end

  private

  def glob_dir(file_pattern)
    Dir["#{dir}/**/#{file_pattern}.{md,html}"]
  end
end
