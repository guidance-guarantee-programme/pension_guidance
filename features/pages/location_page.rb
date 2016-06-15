require_relative 'page'

module Pages
  class Location < Page
    set_url '/locations/{id}'

    element :back_to_results, '.t-back-to-results'
    element :name, '.t-name'
    element :address, '.t-address'
    element :phone, '.t-phone'
    element :hours, '.t-hours'
    element :book_online, '.t-book-online'

    elements :breadcrumbs, '.t-breadcrumb'
  end
end
