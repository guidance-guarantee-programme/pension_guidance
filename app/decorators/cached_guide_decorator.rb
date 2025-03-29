class CachedGuideDecorator < SimpleDelegator
  attr_accessor :cache, :expires_in

  alias object __getobj__

  def initialize(decorator, cache, expires_in = Rails.application.config.cache_max_age)
    __setobj__(decorator)
    self.cache = cache
    self.expires_in = expires_in.to_i
  end

  %i[title content canonical].each do |method|
    define_method(method) do
      cache_key = [object.id, object.locale, method].join('-')
      cache.fetch(cache_key, expires_in: expires_in) { super() }
    end
  end
end
