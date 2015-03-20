class CachedGuideDecorator < SimpleDelegator
  attr_accessor :cache

  def initialize(decorator, cache)
    __setobj__(decorator)
    self.cache = cache
  end

  %i(title content).each do |method|
    define_method(method) do
      cache_key = "#{__getobj__.id}-#{method}"
      cache.fetch(cache_key) { super() }
    end
  end
end
