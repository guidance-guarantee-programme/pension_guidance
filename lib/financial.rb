module Financial
  # Calculates the future value of an asset.
  #
  # @param principal_amount [Float] the amount on which interest will be paid
  # @param additional_amount [Float] the amount that will added each period
  # @param nominal_interest_rate [Float] the stated interest rate
  # @param compounding_frequency [Integer] the number of times interest will be calculated in a period
  # @param periods [Integer] the number of time periods interest will be calculated
  # @return [Float] the future value of the principal amount
  def self.future_value(principal_amount, additional_amount, nominal_interest_rate, compounding_frequency, periods)
    effective_periods = compounding_frequency * periods
    effective_interest_rate = nominal_interest_rate / compounding_frequency
    exponent = (1 + effective_interest_rate)**(effective_periods)

    future_value_of_principal = principal_amount * exponent
    future_value_of_additional = additional_amount * ((exponent - 1) / effective_interest_rate)

    future_value_of_principal + future_value_of_additional
  end
end
