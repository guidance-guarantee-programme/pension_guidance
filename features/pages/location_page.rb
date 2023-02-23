require_relative 'page'

module Pages
  class Location < Page
    set_url '/{locale}/locations/{id}'

    element :canonical, 'link[rel="canonical"]', visible: false
    element :robots, 'meta[name="robots"]', visible: false
    element :back_to_results, '.t-back-to-results'
    element :name, '.t-name'
    element :address, '.t-address'
    element :phone, '.t-phone'
    element :hours, '.t-hours'
    element :book_online, '.t-book-online'
    element :agent_book_online, '.t-agent-book-online'
    element :accessibility_information, '.t-accessibility-information'

    elements :breadcrumbs, '.t-breadcrumb'
  end
end
