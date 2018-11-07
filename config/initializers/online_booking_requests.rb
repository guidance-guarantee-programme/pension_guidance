BookingRequests.api = if (Rails.env.development? || Rails.env.test?) && !ENV['BOOKING_REQUESTS_API_URI']
                        BookingRequests::StubApi.new
                      else
                        BookingRequests::Api.new
                      end
