module ZenDesk
  mattr_accessor :api

  def self.create_ticket(**message_options)
    api.create_ticket(**message_options)
  end
end
