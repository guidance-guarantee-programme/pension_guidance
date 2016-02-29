require_relative 'guide_page'

module Pages
  class GuaranteedIncomeGuide < Guide
    set_url '/guaranteed-income'

    section :calculator, '.t-calculator' do
      element :pot_field, '.t-calculator-pot'
      element :age_field, '.t-calculator-age'
      element :calculate_button, '.t-calculator-submit'

      element :tax_free_lump_sum, '.t-calculator-tax-free-lump-sum'
      element :income, '.t-calculator-income'

      element :notes, '.t-calculator-notes'
    end
  end
end
