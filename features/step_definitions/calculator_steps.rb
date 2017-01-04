Given(/^I am on the adjustable income guide$/) do
  @page = Pages::AdjustableIncomeGuide.new
  @page.load
end

Given(/^I am on the leaving your whole pension pot untouched guide$/) do
  @page = Pages::LeavePotUntouchedGuide.new
  @page.load
end

Given(/^I am on the take cash in chunks guide$/) do
  @page = Pages::TakeCashInChunksGuide.new
  @page.load
end

Given(/^I am on the guaranteed income guide$/) do
  @page = Pages::GuaranteedIncomeGuide.new
  @page.load
end

When(/^I input the total value of my pension pot and how much I could contribute each year$/) do
  calculator = @page.calculator

  calculator.pot_field.set('100,000.00')
  calculator.contribution_field.set('    100   ')
  calculator.calculate_button.click
end

When(/^I input the total value of my pension pot, my income for the year and how much cash I want to take upfront$/) do
  calculator = @page.calculator

  calculator.pot_field.set('40,000.00')
  calculator.income_field.set('  25000   ')
  calculator.chunk_field.set('  3000')
  calculator.calculate_button.click
end

When(/^I input the total value of my pension pot, and the age I will retire$/) do
  calculator = @page.calculator

  calculator.pot_field.set('100,000.00')
  calculator.age_field.set('    55  ')
  calculator.calculate_button.click
end

When(/^I input the total value of my pension pot and my age$/) do
  calculator = @page.calculator

  calculator.pot_field.set('100,000.00')
  calculator.age_field.set('55')
  calculator.calculate_button.click
end

And(/^I change the income to another amount$/) do
  calculator = @page.calculator

  calculator.slider_input.set('500')
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

Then(/^I should see how much tax I might pay$/) do
  expect(@page.calculator.chunk_tax).to have_content('£450 in tax')
end

And(/^I should see how cash I would get$/) do
  expect(@page.calculator.chunk_remaining).to have_content('£2,550')
end

And(/^I should see how the remaining value of my pot$/) do
  expect(@page.calculator.pot_remaining).to have_content('£37,000')
end

Then(/^I should see an income that will last until my life expectancy$/) do
  expect(@page.calculator.desired_income_lasts_until).to have_content('85')
end

Then(/^it shows me what age my desired income will last until$/) do
  expect(@page.calculator.desired_income_lasts_until).to have_content('70')
end

And(/^it shows me a suggested monthly income that will last until an average life expectancy for someone of my age$/) do
  expect(@page.calculator.income_for_life_expectancy).to have_content('mid-to-late 80s')
  expect(@page.calculator.income_for_life_expectancy).to have_content('£316')
end

Then(/^it explains the values are estimates based on growth at 3% per year$/) do
  expect(@page.calculator.notes).to have_content('estimate')
  expect(@page.calculator.notes).to have_content('3%')
end

Then(/^it explains the values are estimates based on the amount remaining growing at 3% per year$/) do
  expect(@page.calculator.notes).to have_content('3% per year')
end

Then(/^it explains the values will be affected by inflation and how much my provider charges for managing the pot$/) do
  expect(@page.calculator.notes).to have_content('inflation')
  expect(@page.calculator.notes).to have_content('fees')
end

Then(/^I should see how much my tax free lump sum could be$/) do
  expect(@page.calculator.tax_free_lump_sum).to have_content('£25,000 tax free')
end

And(/^I should see how much my guaranteed income could be$/) do
  expect(@page.calculator.income).to have_content('£3,100')
end
