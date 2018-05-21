module Pages
  class TescoBooking < SitePrism::Page
    set_url '/{locale}/tesco/locations/{location_id}/bookings/new'

    element :first_name, '.t-first-name'
    element :last_name, '.t-last-name'
    element :email, '.t-email'
    element :date_of_birth_day, '.t-date-of-birth-day'
    element :date_of_birth_month, '.t-date-of-birth-month'
    element :date_of_birth_year, '.t-date-of-birth-year'
    element :phone, '.t-phone'
    element :memorable_word, '.t-memorable-word'
    element :dc_pot_confirmed, '.t-dc-pot-confirmed-yes', visible: false
    element :dc_pot_confirmed_no, '.t-dc-confirmed-pot-no', visible: false
    element :gdpr_consent_yes, '.t-gdpr-consent-yes', visible: false
    element :gdpr_consent_no, '.t-gdpr-consent-no', visible: false
    element :gdpr_consent_no_response, '.t-gdpr-consent-no-response', visible: false

    element :submit, '.t-submit'
    element :continue, '.t-continue'

    def choose_date(date)
      find("button[value='#{date}']").click
    end

    def choose_time(time)
      find('label', text: time).click
    end
  end
end
