module Pages
  class Location < SitePrism::Page
    set_url '/locations/{id}'

    element :name, '.t-name'
    element :address, '.t-address'
    element :phone, '.t-phone'
    element :hours, '.t-hours'
  end
end
