module Pages
  class EmployerLocation < SitePrism::Page
    set_url '/en/employers/{employer_id}/locations/{id}'

    element :name, '.t-name'
    element :address, '.t-address'
    element :book_online, '.t-book-online'
  end
end
