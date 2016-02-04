Given(/^I am on the leaving your whole pension pot untouched guide$/) do
  @page = Pages::LeavePotUntouchedGuide.new
  @page.load
end

When(/^I input the total value of my pension pot and how much I could contribute each year$/) do
  calculator = @page.calculator

  calculator.pot_field.set('100,000.00')
  calculator.contribution_field.set('    100   ')
  calculator.calculate_button.click
end

Then(/^the calculator is displayed$/) do
  expect(@page).to have_calculator
end

Then(/^I should see how much my pot could be worth for each of the next (\d+) years$/) do |years|
  calculator = @page.calculator
  future_pot_sizes = %w(£104,200 £108,526 £112,982 £117,571 £122,298)

  calculator.wait_for_future_pot_sizes

  expect(calculator).to have_future_pot_sizes(count: years)
  expect(calculator.future_pot_size_figures).to eq(future_pot_sizes)
  expect(calculator.years).to have_content("#{years} years")
end

Then(/^it explains the values are estimates based on growth at 3% per year$/) do
  content = 'We’ve estimated your pot could grow at about 3% per year — your growth may be higher or lower than this.'

  expect(@page.calculator.notes).to have_content(content)
end

Then(/^it explains the values will be affected by inflation and how much my provider charges for managing the pot$/) do
  content = 'The value of your pot will be affected by inflation ' \
            'and how much your provider charges you for managing your pot.'

  expect(@page.calculator.notes).to have_content(content)
end
