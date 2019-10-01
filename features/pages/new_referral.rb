require_relative 'page'

module Pages
  class NewReferral < Page
    set_url '/en/referral/new'

    element :surname, '.t-surname'
    element :provider, '.t-pension-provider'
    element :call_outcome, '.t-call-outcome'
    element :date_of_birth_day, '.t-date-of-birth-day'
    element :date_of_birth_month, '.t-date-of-birth-month'
    element :date_of_birth_year, '.t-date-of-birth-year'
    element :submit, '.t-submit'
  end
end
