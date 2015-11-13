RSpec.feature 'Take whole pot calculator analytics', type: :feature, js: true do
  let(:pot) { '100000' }
  let(:income) { '7000' }
  let(:pension) { '5000' }
  let(:pension_frequency) { 'annually' }
  let(:pension_frequency_label) { 'Annual' }

  def data_layer
    Array(page.evaluate_script('window.dataLayer')).reduce({}, :merge)
  end

  scenario 'Calculator inputs available to the Google Tag Manage dataLayer' do
    visit '/take-whole-pot'

    fill_in 'pot', with: pot
    fill_in 'income', with: income
    fill_in 'pension', with: pension
    select pension_frequency_label, from: 'pension_frequency'
    click_on 'Calculate'

    expect(data_layer).to include(
      'pot' => pot,
      'income' => income,
      'pension' => pension,
      'pension_frequency' => pension_frequency
    )
  end
end
