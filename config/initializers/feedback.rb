Feedback.api = if Rails.env.development? || Rails.env.test?
                 Feedback::StubClient.new
               else
                 Feedback::ZenDeskClient.new
               end
