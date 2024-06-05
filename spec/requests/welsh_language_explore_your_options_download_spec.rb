RSpec.describe 'Generating a Welsh language EYO document', type: :request do
  specify 'Successfully generating the document' do
    post '/cy/explore-your-options/welsh-summary', params: {
      appointment_summary: {
        supplementary_benefits: true,
        supplementary_debt: true,
        supplementary_ill_health: true,
        supplementary_defined_benefit_pensions: true,
        supplementary_pension_transfers: true
      }
    }

    @summary = PensionSummary.last
    expect(@summary).to have_attributes(
      welsh_digital: true,
      leave_your_pot_untouched: true,
      get_a_guaranteed_income: true,
      get_an_adjustable_income: true,
      take_cash: true,
      take_whole: true,
      mix_your_options: true,
      how_my_pension_affects_my_benefits: true,
      getting_help_with_debt: true,
      taking_my_pension_if_im_ill: true,
      transferring_my_pension_to_another_provider: true,
      final_salary_career_average: true
    )

    expect(response).to be_redirect
    expect(response.location).to eq(
      "http://www.example.com/cy/explore-your-options/download?id=#{@summary.id}"
    )
  end
end
