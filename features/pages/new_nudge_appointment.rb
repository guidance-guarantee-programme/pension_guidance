module Pages
  class NewNudgeAppointment < SitePrism::Page
    set_url '/en/nudge-appointments/new'

    element :first_name, '.t-first-name'
    element :last_name, '.t-last-name'
    element :email, '.t-email'
    element :mobile, '.t-mobile'
    element :confirmation_email, '.t-confirmation-email'
    element :confirmation_sms, '.t-confirmation-sms'
    element :date_of_birth_day, '.t-date-of-birth-day'
    element :date_of_birth_month, '.t-date-of-birth-month'
    element :date_of_birth_year, '.t-date-of-birth-year'
    element :eligibility_reason, '.t-eligibility-reason'
    element :phone, '.t-phone'
    element :memorable_word, '.t-memorable-word'
    element :accessibility_requirements_yes, '.t-accessibility-requirements-yes'
    element :accessibility_requirements_no, '.t-accessibility-requirements-no'
    element :adjustments, '.t-adjustments'
    element :additional_info, '.t-additional-info'
    element :gdpr_consent_yes, '.t-gdpr-consent-yes'
    element :gdpr_consent_no, '.t-gdpr-consent-no'
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
