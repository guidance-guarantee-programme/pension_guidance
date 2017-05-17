class Breadcrumb
  attr_accessor :path, :title

  def initialize(path, title)
    self.path = path
    self.title = title
  end

  class << self
    include Rails.application.routes.url_helpers

    def book_an_appointment(locale = I18n.locale)
      guide_breadcrumb(:book_an_appointment, locale)
    end

    def book_online(location_id, location_name, locale = I18n.locale)
      new(location_path(location_id, locale: locale), location_name)
    end

    def how_to_book_phone(locale = I18n.locale)
      guide_breadcrumb(:how_to_book_phone, locale)
    end

    def how_to_book_face_to_face(locale = I18n.locale)
      guide_breadcrumb(:how_to_book_face_to_face, locale)
    end

    def pension_options(locale = I18n.locale)
      guide_breadcrumb(:pension_options, locale)
    end

    def book_a_telephone_appointment(locale = I18n.locale)
      title = I18n.t('breadcrumbs.book_a_telephone_appointment')[:title]
      new(new_telephone_appointment_path(locale: locale), title)
    end

    private

    def guide_breadcrumb(translation_key, locale)
      t = I18n.t("breadcrumbs.#{translation_key}")
      new(guide_path(t[:slug], locale: locale), t[:title])
    end
  end
end
