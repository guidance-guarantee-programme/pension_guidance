module Pages
  class BookingStepTwo < SitePrism::Page
    set_url '/locations/{id}/booking-request/step-two'

    element :error, '.t-errors'
    element :first_name, '.t-first-name'
    element :last_name, '.t-last-name'
    element :email, '.t-email'
    element :telephone_number, '.t-telephone-number'
    element :memorable_word, '.t-memorable-word'
    element :accessibility_requirements, '.t-accessibility-requirements'
    element :opt_in, '.t-opt-in'
    element :dc_pot, '.t-dc-pot'

    element :under_fifty, '.t-appointment-type-1'
    element :fifty_to_fifty_four, '.t-appointment-type-2'
    element :over_fifty, '.t-appointment-type-3'

    element :submit, '.t-submit'
    element :back, '.t-back'
  end
end
