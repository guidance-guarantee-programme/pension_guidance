require_relative 'guide_page'

module Pages
  class AdjustableIncomeGuide < Guide
    set_url '/adjustable-income'

    section :calculator, '.t-calculator' do
      element :pot_field, '.t-calculator-pot'
      element :age_field, '.t-calculator-age'
      element :slider_input, '.t-slider-input'
      element :calculate_button, '.t-calculator-submit'

      element :notes, '.t-calculator-notes'

      element :tax_free_lump_sum, '.t-calculator-tax-free-lump-sum'
      element :taxable_portion, '.t-calculator-taxable-portion'
      element :desired_income_lasts_until, '.t-calculator-age-for-desired-income'
      element :income_for_life_expectancy, '.t-calculator-life-expectancy-income'
    end
  end
end
