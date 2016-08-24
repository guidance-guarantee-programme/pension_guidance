ZenDesk.api = if Rails.env.development? || Rails.env.test?
                ZenDesk::StubClient.new
              else
                ZenDesk::Client.new
              end
