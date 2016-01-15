module Sections
  class Footer < SitePrism::Section
    sections :categories, '.t-footer-category' do
      element :header, '.t-footer-category-header'
      elements :links, '.t-footer-category-item a'
    end
  end
end
