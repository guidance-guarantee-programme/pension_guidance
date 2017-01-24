require_relative '../models/guide'
require_relative '../lib/front_matter_parser'

class GuideRepository
  GuideNotFound = Class.new(StandardError)

  attr_accessor :dir
  private :dir, :dir=

  def self.slugs
    @slugs ||= new.slugs
  end

  def initialize(dir = Rails.root.join('content'))
    self.dir = dir
  end

  def find(id)
    dirname = id.tr('-', '_')
    path = glob_dir(dirname)&.first || raise(GuideNotFound)
    locale_paths = glob_dir("#{dirname}.*")
    read_guide(id, path, locale_paths)
  end

  def find_all(*ids)
    ids.each_with_object([]) do |id, results|
      results << find(id)
    end
  end

  def all
    glob_dir('*')
      .group_by { |path| extract_from_path(path, :id) }
      .map do |id, paths|
        base_path = paths.detect { |path| extract_from_path(path, :locale).blank? }
        read_guide(id, base_path, paths - [base_path])
      end
  end

  def slugs
    glob_dir('*').map do |path|
      extract_from_path(path, :id).tr('_', '-')
    end.uniq
  end

  private

  def read_guide(id, base_path, locale_paths)
    locales = Hash[locale_paths.map { |path| [extract_from_path(path, :locale).to_sym, path] }]

    build_guide(
      id,
      file_content_type(base_path),
      front_matter_for(base_path),
      front_matter_for(locales[I18n.locale]),
      locales.keys
    )
  end

  def build_guide(id, content_type, base_source, locale_source, available_locales)
    Guide.new(
      id,
      content: locale_source.content.presence || base_source.content,
      content_type: content_type,
      metadata: base_source.front_matter.merge(locale_source.front_matter),
      available_locales: available_locales
    )
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
    Dir["#{dir}/**/#{file_pattern}.{md,html}"]
  end

  def extract_from_path(path, field)
    path.match(%r{^#{dir}/(?<id>[^\.]+)\.(?:(?<locale>[^\.]+)\.)?(?<ext>.*)$})[field]
  end

  def front_matter_for(path)
    if path
      FrontMatterParser.new(File.read(path))
    else
      FrontMatterParser.new('')
    end
  end
end
