require 'yaml'

class FrontMatterParser
  attr_accessor :source, :content, :front_matter
  private :source=, :content=, :front_matter=

  def initialize(source)
    self.source = source
    parse!
  end

  private

  def parse!
    match_result = source.match(/(?<front_matter>^---$.*?^---$\n)?(?<content>.*)/m)
    self.content = match_result[:content]
    self.front_matter = match_result[:front_matter].present? ? YAML.load(match_result[:front_matter]) : {}
  end
end
