class Breadcrumb
  attr_accessor :path, :title

  def initialize(path, title)
    self.path = path
    self.title = title
  end

  class << self
    def book_an_appointment
      new('/appointments', 'Book a free appointment')
    end

    def how_to_book
      new('/book', 'How to book')
    end

    def pension_options
      new('/pension-pot-options', 'The 6 pension options')
    end
  end
end
