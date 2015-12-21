module ApplicationHelper
  include NavigationHelper

  def format_currency(amount)
    number_to_currency(amount).sub(/\.00$/, '')
  end

  def book_an_appointment_link?
    true
  end

  def link_to_guide(guide)
    link_to(guide.label, guide.url, class: 't-guide-link')
  end
end
