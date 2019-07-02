module Pages
  class EmployerLocations < SitePrism::Page
    set_url '/en/employers/{employer_id}/locations'

    elements :locations, '.t-location'
  end
end
