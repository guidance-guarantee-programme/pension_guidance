require_relative '../models/guide'
require_relative '../lib/front_matter_parser'

class GuideRepository
  GuideNotFound = Class.new(StandardError)

  attr_accessor :dir, :locale
  private :dir, :dir=, :locale, :locale=

  def self.slugs
    @slugs ||= new.slugs
  end

  def self.cacheable_slugs
    slugs.reject { |s| /question-\d+\Z/ === s } # rubocop:disable Style/CaseEquality
  end

  def initialize(locale = I18n.locale, dir = Rails.root.join('content'))
    self.locale = locale
    self.dir = dir
  end

  def find(id)
    dirname = id.tr('-', '_')
    path = glob_dir(dirname)&.first || raise(GuideNotFound)

    read_guide(id, path)
  end

  def find_all(*ids)
    ids.each_with_object([]) do |id, results|
      results << find(id)
    end
  end

  def all
    glob_dir('*').map do |path|
      id = path.match(%r{^#{dir}/(?<id>[^\.]+)\.#{locale}\.(?<ext>.*)$})[:id]
      read_guide(id, path)
    end
  end

  def slugs
    glob_dir('*').map do |path|
      # If looking for all slugs take any locale into consideration and
      # not just the one this repository has been instantiated against
      id = path.match(%r{^#{dir}/(?<id>[^\.]+)\.(?:(?<locale>[^\.]+)\.)?(?<ext>.*)$})[:id]
      id.tr('_', '-')
    end.uniq
  end

  private

  def read_guide(id, path)
    content_type = file_content_type(path)
    source = FrontMatterParser.new(File.read(path))

    Guide.new(id,
              locale,
              content: source.content,
              content_type: content_type,
              metadata: source.front_matter)
  end

  def file_content_type(path)
    case File.extname(path)
    when '.md' then
      :govspeak
    when '.html' then
      :html
    end
  end

  def glob_dir(file_pattern)
    Dir["#{dir}/**/#{file_pattern}.#{locale}.{md,html}"]
  end
end
