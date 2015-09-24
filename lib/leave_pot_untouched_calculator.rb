class LeavePotUntouchedCalculator
  attr_accessor :pot

  def initialize(initial_pot, annual_saving, duration, net_growth_rate)
    @pot = initial_pot

    duration.times do
      new_pot = (pot + annual_saving) * (1 + (net_growth_rate.to_f / 100))
      @pot = (new_pot * 100).round.to_f / 100
    end
  end
end
