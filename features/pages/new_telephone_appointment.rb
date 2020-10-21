module Pages
  class NewTelephoneAppointment < SitePrism::Page
    set_url '/{locale}/telephone-appointments/new'

    element :first_name, '.t-first-name'
    element :last_name, '.t-last-name'
    element :email, '.t-email'
    element :email_suggestion, '.t-suggestion'
    element :date_of_birth_day, '.t-date-of-birth-day'
    element :date_of_birth_month, '.t-date-of-birth-month'
    element :date_of_birth_year, '.t-date-of-birth-year'
    element :phone, '.t-phone'
    element :memorable_word, '.t-memorable-word'
    element :choose_other_time_message, '.t-choose-other-time-message'
    element :where_you_heard, '.t-where-you-heard'
    element :accessibility_requirements, '.t-accessibility-requirements'
    element :additional_info, '.t-additional-info'
    element :smarter_signposting_banner, '.t-smarter-signposted-banner'
    element :cancel_smarter_signposting, '.t-cancel-smarter-signposting'

    element :dc_pot_confirmed_yes, '.t-dc-pot-confirmed-yes'
    element :dc_pot_confirmed_no, '.t-dc-pot-confirmed-no'

    element :gdpr_consent_yes, '.t-gdpr-consent-yes'
    element :gdpr_consent_no, '.t-gdpr-consent-no'

    element :submit, '.t-submit'

    element :continue, '.t-continue'

    # widget elements
    element :branding, '.l-masthead'
    element :skiplink, '.skiplink'
    element :cookie_banner, '#global-cookie-message'
    element :csrf, 'meta[name=csrf-param]'

    def choose_date(date)
      page.choose(date)
    end

    def choose_time(time)
      page.choose(time)
    end
  end
end
