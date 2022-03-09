module ApplicationHelper
  include NavigationHelper

  def book_an_appointment_link?
    true
  end

  def link_to_guide(guide)
    capture do
      if guide.option?
        concat content_tag(:span, nil, class: "circle circle--s circle--#{guide.id}")
      end

      concat link_to(guide.label, guide.url, class: 't-guide-link')
    end
  end

  def disable_scroll_to_top
    '<meta name="disable_scroll_to_top" content="true"/>'.html_safe
  end
end
