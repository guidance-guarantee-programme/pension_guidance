When(/^I visit a guide$/) do
  step 'I visit the tax guide'
end

When(/^I visit a guide that is part of '6 things you need to know'$/) do
  step 'I visit the pension-pot-options guide'
end

When(/^I visit the (.*) guide$/) do |slug|
  @guide = Pages::Guide.new
  @guide.load(slug: slug)
end

Then(/^the guide is displayed$/) do
  expect(@guide).to be_displayed
end

Then(/^the page title corresponds to the title of the guide/) do
  expect(@guide.title).to include('Tax you pay on your pension')
end

And(/^the page heading corresponds to the title of the guide$/) do
  expect(@guide.primary_heading).to have_content('Tax you pay on your pension')
end

Then(/^the page meta description corresponds to the meta description of the guide$/) do
  expected_description = "You pay tax on any income, including pension, that's above your tax-free Personal Allowance."
  expect(@guide).to have_meta(:description, expected_description)
end

Then(/^I can navigate to other steps in that journey$/) do
  expect(@guide.journey_nav_steps.map(&:text))
    .to eq(['Check the value of your pension pot',
            'What you can do with your pension pot (current)',
            'Plan how long your money needs to last',
            "Work out how much money you'll have in retirement",
            'Tax you pay on your pension',
            'How to shop around for the best deal'])
end

Then(/^the current guide is highlighted$/) do
  expect(@guide.journey_nav_current_step.text).to eq('What you can do with your pension pot (current)')
end
