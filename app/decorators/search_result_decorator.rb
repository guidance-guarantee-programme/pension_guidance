class SearchResultDecorator < Draper::Decorator
  def to_partial_path
    'search_result'
  end

  def path
    object.link if defined?(object.link)
  end

  def title
    object.title.sub(Regexp.union(title_suffix_regexps), '').html_safe
  end

  def snippet
    object.snippet.gsub(%r{<br\s*/?>}, '').html_safe
  end

  private

  def title_suffix_regexps
    title = 'Pension Wise'
    length = title.length

    length.times.map do |i|
      is_truncated = i < (length - 1)
      pattern = format(' - %<suffix>s%<ellipsis>s$',
                       suffix: title[0..i],
                       ellipsis: is_truncated ? ' ...' : nil)

      Regexp.new(pattern)
    end
  end
end
