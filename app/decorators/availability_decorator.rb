class AvailabilityDecorator < Draper::Decorator
  delegate_all

  def slots
    object.slots.each_with_object({}) do |slot, options|
      date = slot.strftime('%A, %-d %B %Y')
      options[date] ||= []
      options[date] << [slot.strftime('%l:%M %P'), slot]
      options
    end
  end
end
