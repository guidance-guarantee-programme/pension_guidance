RSpec.feature 'Take whole pot calculator analytics', type: :feature, js: true do
  let(:pot) { '100000' }
  let(:income) { '7000' }
  let(:pension) { '5000' }
  let(:pension_invalid) { '5000000' }
  let(:pension_frequency) { 'annually' }
  let(:pension_frequency_label) { 'Annual' }

  scenario 'with invalid input' do
    enter_invalid_data
    perform_calculation

    expect(data_layer).to include(
      'pot' => pot,
      'income' => income,
      'pension' => pension_invalid,
      'pension_frequency' => pension_frequency,
      'valid' => false
    )
  end

  scenario 'with valid input' do
    enter_valid_data
    perform_calculation

    expect(data_layer).to include(
      'pot' => pot,
      'income' => income,
      'pension' => pension,
      'pension_frequency' => pension_frequency,
      'valid' => true,
      'pot_tax' => '23923.0',
      'pot_received' => '76077.0'
    )
  end

  private

  def data_layer
    Array(page.evaluate_script('window.dataLayer')).reduce({}, :merge)
  end

  def enter_valid_data
    visit '/take-whole-pot'

    fill_in 'pot', with: pot
    fill_in 'income', with: income
    fill_in 'pension', with: pension
    select pension_frequency_label, from: 'pension_frequency'
  end

  def enter_invalid_data
    enter_valid_data
    fill_in 'pension', with: pension_invalid
  end

  def perform_calculation
    click_on 'Calculate'
  end
end
