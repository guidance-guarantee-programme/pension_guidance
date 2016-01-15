When(/^I visit a guide$/) do
  step 'I visit the scams guide'
end

When(/^I visit a guide that is part of '6 steps you need to take'$/) do
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
  expect(@guide.title).to include('How to avoid a pension scam')
end

And(/^the page heading corresponds to the title of the guide$/) do
  expect(@guide.primary_heading).to have_content('How to avoid a pension scam')
end

Then(/^the page meta description corresponds to the meta description of the guide$/) do
  expected_description = 'How to spot the signs of a pension scam, how to protect yourself, ' \
    'and what to do if you’ve been targeted.'
  expect(@guide).to have_meta(:description, expected_description)
end

Then(/^I can navigate to the next step in that journey$/) do
  expect(@guide.pager_item_next).to have_content('Leave pot untouched')
end

Then(/^I can navigate to the previous step in that journey$/) do
  expect(@guide.pager_item_previous).to have_content('Check how much is in your pot')
end

Then(/^I can navigate directly to other steps in that journey$/) do
  expect(@guide.journey_nav_steps.map(&:text))
    .to eq(['Check how much is in your pot',
            'What you can do with your pot (current)',
            'Make your money last',
            'Work out what you’ll have in retirement',
            'Tax you pay on your pension',
            'Shop around and compare providers'])
end

Then(/^the current guide is highlighted$/) do
  expect(@guide.journey_nav_current_step.text).to eq('What you can do with your pot (current)')
end

Then(/^I can navigate to content related to the journey$/) do
  expect(@guide.link_promo_items.map(&:text))
    .to eq(['Your pension when you die',
            'Benefits',
            'Care costs',
            'How to avoid a pension scam'])
end

Then(/^I can navigate to related content$/) do
  expect(@guide.link_promo_items.map(&:text))
    .to eq(['What you can do with your pension pot',
            '6 steps you need to take',
            'Know your pension type',
            'Tax you pay on your pension'])
end

Then(/^I can navigate to content related to booking$/) do
  expect(@guide.link_promo_items.map(&:text))
    .to eq(['What you can do with your pension pot',
            '6 steps you need to take',
            'Know your pension type',
            'Tax you pay on your pension'])
end

Then(/^I can navigate to each option available to me$/) do
  expect(@guide.journey_subnav_steps.map(&:text))
    .to eq(['Leave pot untouched',
            'Guaranteed income',
            'Adjustable income',
            'Take cash in chunks',
            'Take your whole pot',
            'Mix your options'])
end
