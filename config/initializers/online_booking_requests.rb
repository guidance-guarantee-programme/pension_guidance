require_relative '../../app/lib/booking_requests'

BookingRequests.api = if (Rails.env.development? || Rails.env.test?) && !ENV['BOOKING_REQUESTS_API_URI']
                        require_relative '../../app/lib/booking_requests/stub_api'
                        BookingRequests::StubApi.new
                      else
                        require_relative '../../app/lib/booking_requests/api'
                        BookingRequests::Api.new
                      end
