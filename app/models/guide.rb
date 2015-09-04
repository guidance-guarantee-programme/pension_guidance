class Guide
  extend Forwardable

  Metadata = Class.new do
    attr_accessor :label, :concise_label, :description, :experiment

    def initialize(label: nil, concise_label: nil, description: nil, experiment: nil)
      self.label = label
      self.concise_label = concise_label
      self.description = description
      self.experiment = experiment
    end
  end

  attr_reader :id, :content, :content_type
  def_delegators :@metadata, :label, :concise_label, :description, :experiment

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
end
