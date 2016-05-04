require_relative 'page'

module Pages
  class Home < Page
    set_url '/'

    elements :links, '.t-article-links'
    element :appointment_summary_link, '.t-appointment-summary-link'
  end
end
