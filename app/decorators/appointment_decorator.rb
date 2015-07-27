class AppointmentDecorator < Draper::Decorator
  delegate_all

  def date
    @date ||= object.slot.strftime('%A, %-d %B %Y')
  end

  def time
    @time ||= object.slot.strftime('%l:%M %P')
  end

  def kind
    @kind ||= object.type.capitalize
  end
end
