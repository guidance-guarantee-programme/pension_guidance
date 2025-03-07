require_relative 'page'

module Pages
  class WelshLanguageBookingRequest < Page
    set_url '/cy/booking-requests/new'

    element :face_to_face_booking, '.t-face-to-face-booking', visible: false
    element :phone_booking, '.t-phone-booking', visible: false
    element :location, '.t-location'
    element :first_name, '.t-first-name'
    element :last_name, '.t-last-name'
    element :email, '.t-email'
    element :phone, '.t-phone'
    element :memorable_word, '.t-memorable-word'
    element :day_of_birth, '.t-date-of-birth-day'
    element :month_of_birth, '.t-date-of-birth-month'
    element :year_of_birth, '.t-date-of-birth-year'
    element :defined_contribution_pot_confirmed_yes, '.t-dc-pot-1', visible: false
    element :accessibility_needs_yes, '.t-accessibility-needs-yes'
    element :accessibility_needs_no, '.t-accessibility-needs-no'
    element :adjustments, '.t-adjustments'
    element :additional_info, '.t-additional-info'
    element :where_you_heard, '.t-where-you-heard'
    element :gdpr_consent_yes, '.t-gdpr-consent-yes', visible: false
    element :submit, '.t-submit'

    elements :errors, '.form-group-error'
  end
end
