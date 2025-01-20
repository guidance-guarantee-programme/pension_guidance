module Pages
  class NewTelephoneAppointment < SitePrism::Page
    set_url '/{locale}/telephone-appointments/new{?query*}'

    element :first_name, '.t-first-name'
    element :last_name, '.t-last-name'
    element :email, '.t-email'
    element :email_suggestion, '.t-suggestion'
    element :date_of_birth_day, '.t-date-of-birth-day'
    element :date_of_birth_month, '.t-date-of-birth-month'
    element :date_of_birth_year, '.t-date-of-birth-year'
    element :country_of_residence, '.t-country-of-residence'
    element :phone, '.t-phone'
    element :memorable_word, '.t-memorable-word'
    element :choose_other_time_message, '.t-choose-other-time-message'
    element :where_you_heard, '.t-where-you-heard'
    element :accessibility_requirements, '.t-accessibility-requirements'
    element :additional_info, '.t-additional-info'
    element :smarter_signposting_banner, '.t-smarter-signposted-banner'
    element :cancel_smarter_signposting, '.t-cancel-smarter-signposting'
    element :lloyds_signposting_banner, '.t-lloyds-signposted-banner'
    element :change_date_time, '.t-change-date-time'

    element :dc_pot_confirmed_yes, '.t-dc-pot-confirmed-yes'
    element :dc_pot_confirmed_no, '.t-dc-pot-confirmed-no'

    element :attended_digital_yes, '.t-attended-digital-yes'
    element :attended_digital_no, '.t-attended-digital-no'
    element :attended_digital_not_sure, '.t-attended-digital-not-sure'

    element :gdpr_consent_yes, '.t-gdpr-consent-yes'
    element :gdpr_consent_no, '.t-gdpr-consent-no'

    element :submit, '.t-submit'

    element :continue, '.t-continue'

    # widget elements
    element :branding, '.l-masthead'
    element :skiplink, '.skiplink'
    element :cookie_banner, '#global-cookie-message'
    element :csrf, 'meta[name=csrf-param]'

    # due diligence removals or additions
    element :alternative_journeys, '.t-alternative-journeys'
    element :need_help_banner, '.t-need-help-banner'
    element :date_of_birth_hint, '.t-dob-hint'
    element :hidden_dc_pot_confirmed, '.t-hidden-dc-pot-confirmed', visible: false
    element :hidden_gdpr_consent, '.t-hidden-gdpr-consent', visible: false
    element :hidden_where_you_heard, '.t-hidden-where-you-heard', visible: false
    element :data_sharing_banner, '.t-data-sharing-banner'
    element :referrer, '.t-referrer'

    def choose_date(date)
      find("button[value='#{date}']").click
    end

    def choose_time(time)
      find('label', text: time).click
    end
  end
end
