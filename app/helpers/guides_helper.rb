module GuidesHelper
  def book_an_appointment_link?
    !@guide.related_to_appointments?
  end
end
