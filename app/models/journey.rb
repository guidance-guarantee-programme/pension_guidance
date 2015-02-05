class Journey
  include Enumerable

  def initialize(*steps)
    @steps = steps
  end

  def each(&block)
    @steps.each(&block)
  end
end
