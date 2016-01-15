module ApplicationHelper
  def format_currency(amount)
    number_to_currency(amount).sub(/\.00$/, '')
  end

  def book_an_appointment_link?
    true
  end
end
