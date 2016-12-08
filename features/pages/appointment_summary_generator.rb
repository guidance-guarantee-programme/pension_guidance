module Pages
  class AppointmentSummaryGenerator < Page
    set_url '/summary-document/new'

    section :generator, '.t-appointment-summary-generator' do
      element :appointment_type_standard, '.t-appointment-type-standard'
      element :appointment_type_50_54, '.t-appointment-type-50-54'

      element :supplementary_benefits, '.t-supplementary-benefits'
      element :supplementary_debt, '.t-supplementary-debt'
      element :supplementary_ill_health, '.t-supplementary-ill-health'
      element :supplementary_defined_benefit_pensions, '.t-supplementary-defined-benefit-pensions'
      element :supplementary_pension_transfers, '.t-supplementary-pension-transfers'

      element :submit_button, '.t-appointment-summary-submit'
    end
  end
end
