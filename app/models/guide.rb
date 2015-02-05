class Guide
  attr_reader :id, :source, :source_type

  def initialize(id, source = '', source_type = nil)
    @id = id
    @source = source
    @source_type = source_type
  end

  def ==(other)
    id == other.id
  end

  def slug
    id.tr('_', '-')
  end
end
