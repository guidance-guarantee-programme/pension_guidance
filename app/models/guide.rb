class Guide
  attr_reader :id, :content, :content_type, :metadata

  def initialize(id, content: '', content_type: nil, metadata: nil)
    @id = id
    @content = content
    @content_type = content_type
    @metadata = OpenStruct.new(metadata)
  end

  def ==(other)
    id == other.id
  end

  def slug
    id.tr('_', '-')
  end

  def option?
    tagged_with?('option')
  end

  def related_to_journey?
    tagged_with?('option')
  end

  def related_to_appointments?
    tagged_with?('appointments')
  end

  def related_to_booking?
    tagged_with?('booking')
  end

  private

  def tagged_with?(tag)
    Array(metadata.tags).include?(tag)
  end
end
