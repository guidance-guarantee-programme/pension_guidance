require_relative 'page'

module Pages
  class Home < Page
    set_url '/{locale}'

    elements :links, '.t-article-links'
    element :appointment_summary_link, '.t-appointment-summary-link'

    element :book, '.t-book'
    element :who, '.t-who'
    element :what, '.t-what'
    element :how, '.t-how'
  end
end
