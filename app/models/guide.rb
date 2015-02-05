class Guide
  attr_reader :id, :source

  def initialize(id, source = '')
    @id = id
    @source = source
  end

  def ==(other)
    id == other.id
  end

  def slug
    id.tr('_', '-')
  end
end
