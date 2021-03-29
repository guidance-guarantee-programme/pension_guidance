RSpec.feature 'Take whole pot calculator analytics', type: :feature, js: true do
  let(:pot) { '100,000' }
  let(:income) { '7,000' }

  scenario 'with invalid input' do
    enter_invalid_data
    perform_calculation

    wait_for_ajax

    expect(data_layer).to include('event' => 'CalculatorEstimate', 'valid' => false)
  end

  scenario 'with valid input' do
    enter_valid_data
    perform_calculation

    wait_for_ajax

    expect(data_layer).to include(
      'event' => 'CalculatorEstimate',
      'valid' => true,
      'income' => 7_000,
      'pot' => 100_000,
      'tax_paid' => 20_232,
      'pot_payout' => 79_768
    )
  end

  private

  def data_layer
    script = <<-eos
      cleanDataLayer = []
      for (var i = 0; i < window.dataLayer.length; i++) {
        if (window.dataLayer[i].event == 'CalculatorEstimate') {
          cleanDataLayer.push(window.dataLayer[i]);
        }
      }
    eos

    page.execute_script(script)
    Array(page.evaluate_script('cleanDataLayer')).reduce({}, :merge)
  end

  def enter_valid_data
    visit '/en/take-whole-pot'
    click_on 'Accept all cookies'

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
