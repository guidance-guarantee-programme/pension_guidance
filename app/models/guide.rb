class Guide
  attr_reader :id, :source, :description

  def initialize(id, source = '', description = '')
    @id = id
    @source = source
    @description = description
  end

  def slug
    id.tr('_', '-')
  end
end
