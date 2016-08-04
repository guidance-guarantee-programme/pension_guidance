require_relative '../sections/feedback'

module Pages
  class Feedback < SitePrism::Page
    set_url '/feedback/new'

    section :feedback, Sections::Feedback, '.t-feedback'

    elements :errors, '.error-message'
  end
end
