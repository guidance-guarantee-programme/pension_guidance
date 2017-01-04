module Financial
  # Calculates the future value of an asset.
  #
  # @param principal_amount [Float] the amount on which interest will be paid
  # @param additional_amount [Float] the amount that will added each period
  # @param nominal_interest_rate [Float] the stated interest rate
  # @param periods [Integer] the number of time periods interest will be calculated
  # @return [Float] the future value of the principal amount
  def self.future_value(principal_amount, additional_amount, nominal_interest_rate, periods)
    future_value_of_principal = principal_amount * (1 + nominal_interest_rate)**periods
    future_value_of_additional = additional_amount * ((1 + nominal_interest_rate)**periods - 1) / nominal_interest_rate

    future_value_of_principal + future_value_of_additional
  end
end
