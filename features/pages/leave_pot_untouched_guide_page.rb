require_relative 'guide_page'

module Pages
  class LeavePotUntouchedGuide < Guide
    set_url '/leave-pot-untouched'

    section :calculator, '.t-calculator' do
      element :pot_field, '.t-calculator-pot'
      element :contribution_field, '.t-calculator-contribution'
      element :calculate_button, '.t-calculator-submit'

      element :notes, '.t-calculator-notes'
      element :years, '.t-calculator-years'

      elements :future_pot_sizes, '.t-calculator-future-pot-size'

      def future_pot_size_figures
        future_pot_sizes.collect(&:text)
      end
    end
  end
end
