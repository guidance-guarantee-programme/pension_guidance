class Guide
  attr_reader :id, :content, :content_type, :label, :description

  def initialize(id, content: '', content_type: nil, label: '', description: '')
    @id = id
    @content = content
    @content_type = content_type
    @label = label
    @description = description
  end

  def ==(other)
    id == other.id
  end

  def slug
    id.tr('_', '-')
  end
end
