require_relative 'page'

module Pages
  class Home < Page
    set_url '/{locale}'

    elements :links, '.t-article-links'
    element :appointment_summary_link, '.t-appointment-summary-link'

    elements :options, '.t-option'
  end
end
