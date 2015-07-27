class Availability
  include Draper::Decoratable

  attr_reader :slots

  MIN_DAYS = 3
  MAX_DAYS = MIN_DAYS + 14
  TIME_SLOTS = %w(8:30 9:30 9:50 10:50 11:00 11:20 12:20 13:30 13:50 14:30 14:50 15:50 16:00 17:20)

  private_constant :MIN_DAYS, :MAX_DAYS, :TIME_SLOTS

  Timeslot = Struct.new(:hour, :min)

  def initialize
    @slots = []

    time_period.each do |date|
      time_slots.each do |time_slot|
        @slots << date.change(hour: time_slot.hour, min: time_slot.min)
      end
    end
  end

  private

  def time_period
    start_period = MIN_DAYS.days.from_now.to_datetime
    end_period = MAX_DAYS.days.from_now.to_datetime

    (start_period..end_period).reject { |date| date.saturday? || date.sunday? }
  end

  def time_slots
    TIME_SLOTS.collect do |time_slot|
      hour, min = time_slot.split(':').map(&:to_i)
      Timeslot.new(hour, min)
    end
  end
end
