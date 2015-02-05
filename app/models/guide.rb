class Guide
  attr_reader :id, :content, :content_type, :description

  def initialize(id, content: '', content_type: nil, description: '')
    @id = id
    @content = content
    @content_type = content_type
    @description = description
  end

  def ==(other)
    id == other.id
  end

  def slug
    id.tr('_', '-')
  end
end
