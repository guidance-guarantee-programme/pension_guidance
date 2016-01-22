When(/^I input the total value of my pension pot and how much I could contribute each year$/) do
  @page.calculator.pot_field.set(50_000)
  @page.calculator.contribution_field.set(100)
  @page.calculator.calculate_button.submit
end

Then(/^the calculator is displayed$/) do
  expect(@page).to have_calculator
end

Then(/^I should see how much my pot could be worth for each of the next 5 years$/) do
  pending
end

Then(/^it explains the values are estimates based on growth at 3% per year$/) do
  content = 'We’ve estimated your pot could grow at 3% per year - your growth may be higher or lower than this.'

  expect(@page.calculator.notes).to have_content(content)
end

Then(/^it explains the values will be affected by inflation and how much my provider charges for managing the pot$/) do
  content = 'The value of your pot will be affected by inflation ' \
            'and how much your provider charges you for managing your pot.'

  expect(@page.calculator.notes).to have_content(content)
end
