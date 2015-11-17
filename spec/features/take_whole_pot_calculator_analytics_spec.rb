RSpec.feature 'Take whole pot calculator analytics', type: :feature, js: true do
  let(:pot) { '100,000' }
  let(:income) { '7,000' }
  let(:pension) { '115.95' }
  let(:pension_invalid) { '500' }
  let(:pension_frequency) { 'weekly' }
  let(:pension_frequency_label) { 'Weekly' }

  scenario 'with invalid input' do
    enter_invalid_data
    perform_calculation

    expect(data_layer).to include(
      'pot' => 100_000,
      'income' => 7_000,
      'annual_pension' => 26_000,
      'valid' => false
    )
  end

  scenario 'with valid input' do
    enter_valid_data
    perform_calculation

    expect(data_layer).to include(
      'pot' => 100_000,
      'income' => 7_000,
      'annual_pension' => 6029,
      'valid' => true,
      'pot_tax' => 24_128,
      'pot_received' => 75_871
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
