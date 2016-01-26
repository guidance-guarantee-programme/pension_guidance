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

    def how_to_book_phone
      new('/book-phone', 'How to book a phone appointment')
    end

    def how_to_book_face_to_face
      new('/book-face-to-face', 'How to book a face to face appointment')
    end

    def pension_options
      new('/pension-pot-options', 'What you can do with your pot')
    end
  end
end
