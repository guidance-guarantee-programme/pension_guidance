class GuideRepository
  GuideNotFound = Class.new(StandardError)

  def initialize(dir = Rails.root.join('content'))
    self.dir = dir
  end

  def find(id)
    path = path(id)

    if File.exist?(path)
      read_guide(id, path)
    else
      fail GuideNotFound
    end
  end

  def all
    Dir["#{dir}/**/*.md"].each_with_object([]) do |path, result|
      id = File.basename(path, '.md')
      result << read_guide(id, path)
    end
  end

  private

  attr_accessor :dir

  def path(id)
    param = "#{id.tr('-', '_')}.md"

    File.expand_path(param, dir)
  end

  def read_guide(id, path)
    source = FrontMatterParser.new(File.read(path))

    Guide.new(id, source.content, source.front_matter['description'])
  end
end
