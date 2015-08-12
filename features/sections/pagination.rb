module Sections
  class Pagination < SitePrism::Section
    element :next_button, '.t-button--next'
    element :next_title, '.t-title--next'
    element :previous_button, '.t-button--previous'
    element :previous_title, '.t-title--previous'
  end
end
