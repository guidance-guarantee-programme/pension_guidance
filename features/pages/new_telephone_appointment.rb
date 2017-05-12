module Pages
  class NewTelephoneAppointment < SitePrism::Page
    set_url '/telephone-appointments/new'

    element :first_name, '.t-first-name'
    element :last_name, '.t-last-name'
    element :email, '.t-email'
    element :date_of_birth_day, '.t-date-of-birth-day'
    element :date_of_birth_month, '.t-date-of-birth-month'
    element :date_of_birth_year, '.t-date-of-birth-year'
    element :phone, '.t-phone'
    element :memorable_word, '.t-memorable-word'
    element :choose_other_time_message, '.t-choose-other-time-message'

    element :dc_pot_confirmed_no, '.t-dc-confirmed-pot-no', visible: false

    element :submit, '.t-submit'

    element :continue, '.t-continue'

    def choose_date(date)
      page.choose(date)
    end

    def choose_time(time)
      page.choose(time)
    end
  end
end
