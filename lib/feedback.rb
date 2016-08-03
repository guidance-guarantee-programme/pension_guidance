module Feedback
  mattr_accessor :api

  def self.create_ticket(message)
    api.create_ticket(message)
  end
end
