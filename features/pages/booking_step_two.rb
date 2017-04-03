module Pages
  class BookingStepTwo < Page
    set_url '/locations/{id}/booking-request/step-two'

    element :error, '.t-errors'
    element :first_name, '.t-first-name'
    element :last_name, '.t-last-name'
    element :email, '.t-email'
    element :date_of_birth_day, '.t-date-of-birth-day'
    element :date_of_birth_month, '.t-date-of-birth-month'
    element :date_of_birth_year, '.t-date-of-birth-year'
    element :telephone_number, '.t-telephone-number'
    element :memorable_word, '.t-memorable-word'
    element :accessibility_requirements, '.t-accessibility-requirements', visible: false
    element :opt_in, '.t-opt-in', visible: false

    element :dc_pot_yes, '.t-dc-pot-1', visible: false
    element :dc_pot_no, '.t-dc-pot-2', visible: false
    element :dc_pot_not_sure, '.t-dc-pot-3', visible: false

    element :submit, '.t-submit'
    element :back, '.t-back'
  end
end
