class CachedGuideDecorator < SimpleDelegator
  attr_accessor :cache, :expires_in

  def initialize(decorator, cache, expires_in = Rails.application.config.cache_max_age)
    __setobj__(decorator)
    self.cache = cache
    self.expires_in = expires_in
  end

  %i(title content).each do |method|
    define_method(method) do
      cache_key = "#{__getobj__.id}-#{method}"
      cache.fetch(cache_key, expires_in: expires_in) { super() }
    end
  end
end
