module Sections
  class Search < SitePrism::Section
    element :input, '.t-search__input'
    element :submit, '.t-search__submit'
  end
end
