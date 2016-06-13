class Guide
  extend Forwardable

  Metadata = Class.new do
    attr_accessor :label, :concise_label, :description, :tags

    def initialize(label: nil, concise_label: nil, description: nil, tags: nil)
      self.label = label
      self.concise_label = concise_label
      self.description = description
      self.tags = tags
    end
  end

  attr_reader :id, :content, :content_type
  def_delegators :@metadata, :label, :concise_label, :description, :tags

  def initialize(id, content: '', content_type: nil, metadata: nil)
    @id = id
    @content = content
    @content_type = content_type
    @metadata = metadata
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
    Array(tags).include?(tag)
  end
end
