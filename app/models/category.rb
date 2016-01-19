class Category
  attr_accessor :id, :title, :description
  private :id=, :title=, :description=

  def initialize(id, title: nil, description: nil)
    self.id = id
    self.title = title
    self.description = description
  end

  def ==(other)
    id == other.id
  end
end
