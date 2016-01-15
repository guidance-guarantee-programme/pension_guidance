class Category
  attr_accessor :id, :title
  private :id=, :title=

  def initialize(id, title: nil)
    self.id = id
    self.title = title
  end

  def ==(other)
    id == other.id
  end
end
