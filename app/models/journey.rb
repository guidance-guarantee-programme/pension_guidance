class Journey
  include Enumerable

  attr_accessor :steps
  private :steps=

  def initialize(*steps)
    self.steps = steps
  end

  def each(&block)
    steps.each(&block)
  end
end
