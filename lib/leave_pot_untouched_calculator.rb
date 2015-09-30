class LeavePotUntouchedCalculator
  def initialize(initial_pot, annual_saving, duration, net_growth_rate)
    @initial_pot = initial_pot
    @annual_saving = annual_saving
    @duration = duration
    @net_growth_rate = net_growth_rate
  end

  def pot
    [].tap do |result|
      duration.times do
        current_pot = result.last || initial_pot
        new_pot = (current_pot + annual_saving) * growth_factor
        result << round_with_precision(new_pot)
      end
    end
  end

  def growth_factor
    1 + (net_growth_rate.to_f / 100)
  end

  private

  attr_accessor :initial_pot, :annual_saving, :duration, :net_growth_rate

  def round_with_precision(number)
    (number * 100).round.to_f / 100
  end
end
