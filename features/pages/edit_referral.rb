require_relative 'page'

module Pages
  class EditReferral < Page
    set_url '/en/referral/edit'

    element :call_outcome, '.t-outcome'
    element :submit, '.t-submit'
  end
end
