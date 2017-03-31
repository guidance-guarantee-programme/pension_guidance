require_relative 'guide_page'

module Pages
  class TakeCashInChunksGuide < Guide
    set_url '/{locale}/take-cash-in-chunks'

    section :calculator, '.t-calculator' do
      element :chunk_field, '.t-calculator-chunk'
      element :income_field, '.t-calculator-income'
      element :pot_field, '.t-calculator-pot'

      element :calculate_button, '.t-calculator-submit'

      element :chunk, '.t-calculator-chunk'
      element :chunk_remaining, '.t-calculator-chunk-remaining'
      element :chunk_tax, '.t-calculator-chunk-tax'
      element :pot, '.t-calculator-pot'
      element :pot_remaining, '.t-calculator-pot-remaining'
    end
  end
end
