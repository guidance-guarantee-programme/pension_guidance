BookingRequests.api = if Rails.env.development?
                        BookingRequests::StubApi.new
                      else
                        BookingRequests::Api.new
                      end
