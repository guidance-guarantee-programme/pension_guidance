require 'active_model'

class Entity
  include ActiveModel::Validations

  attr_accessor :id
  private :id=

  validates :id, presence: true

  def initialize(id, attributes = {})
    self.id = id

    Array(attributes).each do |name, value|
      send("#{name}=", value) if respond_to?("#{name}=")
    end
  end

  def ==(other)
    self.class == other.class && id == other.id
  end

  alias eql? ==
end
