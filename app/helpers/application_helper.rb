module ApplicationHelper
  include NavigationHelper

  def contact_number(appointment)
    if appointment.due_diligence?
      '0800 015 4906'
    elsif appointment.embedded?
      '0800 100 166'
    else
      '0800 138 3944'
    end
  end

  def contact_hours(appointment)
    if appointment.due_diligence?
      '9am to 5pm'
    else
      '8am to 6:30pm'
    end
  end

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
