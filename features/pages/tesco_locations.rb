module Pages
  class TescoLocations < SitePrism::Page
    set_url '/en/tesco/locations'

    elements :locations, '.t-location'
  end
end
