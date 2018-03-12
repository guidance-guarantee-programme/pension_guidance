module Pages
  class TescoLocation < SitePrism::Page
    set_url '/en/tesco/locations/{id}'

    element :name, '.t-name'
    element :address, '.t-address'
    element :book_online, '.t-book-online'
  end
end
