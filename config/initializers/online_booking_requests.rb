BookingRequests.api = if Rails.env.development? || Rails.env.test?
                        BookingRequests::StubApi.new
                      else
                        BookingRequests::Api.new
                      end
