RSpec.feature 'Take whole pot calculator analytics', type: :feature, js: true do
  let(:pot) { '100,000' }
  let(:income) { '7,000' }

  scenario 'with invalid input' do
    enter_invalid_data
    perform_calculation

    expect(data_layer).to include(
      'pot' => 0,
      'income' => 7_000,
      'valid' => false
    )
  end

  scenario 'with valid input' do
    enter_valid_data
    perform_calculation

    expect(data_layer).to include(
      'pot' => 100_000,
      'income' => 7_000,
      'valid' => true,
      'pot_tax' => 22_203,
      'pot_received' => 77_797
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
  end

  def enter_invalid_data
    enter_valid_data
    fill_in 'pot', with: ''
  end

  def perform_calculation
    click_on 'Calculate'
  end
end
