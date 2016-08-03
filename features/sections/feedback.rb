module Sections
  class Feedback < SitePrism::Section
    element :toggle, '.t-toggle-feedback'
    element :name, '.t-feedback-name'
    element :email, '.t-feedback-email'
    element :message, '.t-feedback-message'
    element :submit, '.t-feedback-submit'
  end
end
