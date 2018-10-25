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

  def email_validation_data_attributes
    {
      'email-validation': true,
      api_key: ENV.fetch('MAILGUN_VALIDATION_KEY') { 'pubkey-b37c931b1fcef90bf2d83b7cdfd6df39' },
      api_host: Rails.env.test? ? 'http://localhost:9293' : nil
    }
  end
end
