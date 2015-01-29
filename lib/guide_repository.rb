class GuideRepository
  GuideNotFound = Class.new(StandardError)

  def initialize(dir = Rails.root.join('content'))
    self.dir = dir
  end

  def find(id)
    path = path(id)

    if File.exist?(path)
      Guide.new(id, File.read(path))
    else
      fail GuideNotFound
    end
  end

  def all
    Dir["#{dir}/**/*.md"].each_with_object([]) do |path, result|
      result << Guide.new(File.basename(path, '.md'), File.read(path))
    end
  end

  private

  attr_accessor :dir

  def path(id)
    param = "#{id.tr('-', '_')}.md"

    File.expand_path(param, dir)
  end
end
