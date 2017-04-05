class Breadcrumb
  attr_accessor :path, :title

  def initialize(path, title)
    self.path = path
    self.title = title
  end

  class << self
    include Rails.application.routes.url_helpers

    def book_an_appointment(locale = I18n.locale)
      new(guide_path('appointments', locale: locale), 'Book a free appointment')
    end

    def book_online(location_id, location_name, locale = I18n.locale)
      new(location_path(location_id, locale: locale), location_name)
    end

    def how_to_book_phone(locale = I18n.locale)
      new(guide_path('book-phone', locale: locale), 'How to book a phone appointment')
    end

    def how_to_book_face_to_face(locale = I18n.locale)
      new(guide_path('book-face-to-face', locale: locale), 'Find an appointment location near you')
    end

    def pension_options(locale = I18n.locale)
      new(guide_path('pension-pot-options', locale: locale), 'What you can do with your pot')
    end

    def book_a_telephone_appointment(locale = I18n.locale)
      new(new_telephone_appointment_path(locale: locale), 'Book a phone appointment')
    end
  end
end
