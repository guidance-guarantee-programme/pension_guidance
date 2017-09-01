module Pages
  class TescoLocations < SitePrism::Page
    set_url '/en/tesco/locations'

    sections :locations, '.t-location' do
      element :name, '.t-name'
      element :address, '.t-address'
      element :book_online, '.t-book-online'
    end
  end
end
