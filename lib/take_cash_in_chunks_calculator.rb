class TakeCashInChunksCalculator
  attr_accessor :pot, :income, :chunk

  delegate :pot_tax, :pot_received, to: :take_whole_pot_calculator

  def initialize(pot, income, chunk)
    self.pot = pot
    self.income = income
    self.chunk = chunk
  end

  def pot_remaining
    pot - chunk
  end

  private

  def take_whole_pot_calculator
    @take_whole_pot_calculator ||= TakeWholePotCalculator.new(chunk, income)
  end
end
