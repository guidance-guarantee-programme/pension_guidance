module LocationsHelper
  def agent_booking_path(location_id)
    planner = ENV.fetch('BOOKING_REQUESTS_API_URI') do
      'http://localhost:3001'
    end

    "#{planner}/locations/#{location_id}/booking_requests/new"
  end

  def book_an_appointment_link?
    false
  end
end
